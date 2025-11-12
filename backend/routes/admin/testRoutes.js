import express from "express";
import db from "../../db.js";

const router = express.Router();


// Utility: shuffle (non-mutating)
const shuffle = (arr) => [...arr].sort(() => Math.random() - 0.5);

/* ============================================================
   ✅ CREATE BALANCED TEST + RANDOMIZED ASSIGNMENT
   POST /admin/tests/create-balanced
   ============================================================ */
router.post("/create-balanced", async (req, res) => {
  const connection = await db.getConnection();

  try {
    const {
      name,
      stream_id,
      total_questions,
      randomize = true,
      assigned_to,
      assigned_id,
    } = req.body;

    const finalStreamId = Number(stream_id);
    const finalTotalQuestions = Number(total_questions);
    const finalAssignedTo = assigned_to || null;
    const finalAssignedId = assigned_id || null;

    if (!finalStreamId || !name?.trim()) {
      return res
        .status(400)
        .json({ message: "Stream ID and test name are required" });
    }

    await connection.beginTransaction();

    // ✅ Step 1: Fetch subjects for this stream
    const [subjects] = await connection.query(
      "SELECT id FROM subjects WHERE stream_id = ?",
      [finalStreamId]
    );
    if (!subjects.length)
      return res
        .status(404)
        .json({ error: "No subjects found for this stream" });

    // ✅ Step 2: Build subject→category→chapter hierarchy
    const hierarchy = [];
    for (const subj of subjects) {
      const [categories] = await connection.query(
        "SELECT id FROM categories WHERE subject_id = ?",
        [subj.id]
      );
      for (const cat of categories) {
        const [chapters] = await connection.query(
          "SELECT id FROM chapters WHERE category_id = ?",
          [cat.id]
        );
        for (const chap of chapters) {
          hierarchy.push({
            subject_id: subj.id,
            category_id: cat.id,
            chapter_id: chap.id,
          });
        }
      }
    }

    if (!hierarchy.length)
      return res
        .status(404)
        .json({ error: "No chapters found for this stream" });

    // ✅ Step 3: Select balanced questions
    const perUnit = Math.max(
      1,
      Math.floor(finalTotalQuestions / hierarchy.length)
    );
    const difficulties = ["easy", "medium", "hard"];
    const selected = [];

    for (const unit of hierarchy) {
      for (const diff of difficulties) {
        const [qs] = await connection.query(
          `SELECT id FROM questions
           WHERE subject_id=? AND category_id=? AND chapter_id=? AND level=?
           ORDER BY RAND() LIMIT ?`,
          [
            unit.subject_id,
            unit.category_id,
            unit.chapter_id,
            diff,
            Math.max(1, Math.floor(perUnit / 3)),
          ]
        );
        selected.push(...qs.map((q) => q.id));
      }
    }

    if (!selected.length) {
      await connection.rollback();
      return res.status(404).json({
        success: false,
        message: "No questions found for selected stream and difficulty levels",
      });
    }

    const finalQuestions = randomize ? shuffle(selected) : selected;

    // ✅ Step 4: Insert test record
    const [testRes] = await connection.query(
      "INSERT INTO tests (name, stream_id, total_questions, randomize) VALUES (?, ?, ?, ?)",
      [name, finalStreamId, finalTotalQuestions, randomize]
    );
    const test_id = testRes.insertId;

    // ✅ Step 5: Link questions
    const values = finalQuestions.map((id) => [test_id, id]);
    await connection.query(
      "INSERT INTO test_questions (test_id, question_id) VALUES ?",
      [values]
    );

    // ✅ Step 6: Assignment logic
    if (finalAssignedTo && finalAssignedId) {
      // direct assignment
      await connection.query(
        "INSERT INTO test_assignments (test_id, assigned_to, assigned_id) VALUES (?, ?, ?)",
        [test_id, finalAssignedTo, finalAssignedId]
      );
    } else {
      // 🧠 Smart randomized assignment

      // 1️⃣ Fetch all students in stream
      const [students] = await connection.query(
        "SELECT id FROM students WHERE stream_id = ?",
        [finalStreamId]
      );

      if (students.length === 0) {
        await connection.commit();
        return res.json({
          success: true,
          message: "Test created — no students found in this stream yet.",
          test_id,
        });
      }

      // 2️⃣ Get all existing tests in this stream
      const [existingTests] = await connection.query(
        "SELECT id FROM tests WHERE stream_id = ? ORDER BY created_at ASC",
        [finalStreamId]
      );

      // 3️⃣ Shuffle both lists for randomness
      const shuffledStudents = shuffle(students);
      const shuffledTests = shuffle(existingTests);

      // 4️⃣ Round-robin or random distribution
      const assignments = shuffledStudents.map((student, idx) => {
        const testIndex = idx % shuffledTests.length;
        return [shuffledTests[testIndex].id, "student", student.id];
      });

      await connection.query(
        "INSERT INTO test_assignments (test_id, assigned_to, assigned_id) VALUES ?",
        [assignments]
      );

      console.log(
        `✅ Distributed ${existingTests.length} tests randomly among ${students.length} students in stream ${finalStreamId}`
      );
    }

    await connection.commit();

    res.json({
      success: true,
      message: "Balanced test created and distributed successfully",
      test_id,
      total_questions: finalQuestions.length,
    });
  } catch (err) {
    await connection.rollback();
    console.error("❌ Error generating or assigning test:", err);
    res.status(500).json({ error: "Error generating balanced test" });
  } finally {
    connection.release();
  }
});
/* ============================================================
   ✅ PREVIEW QUESTION DISTRIBUTION
   GET /admin/tests/preview?stream_id=#
   ============================================================ */
router.get("/preview", async (req, res) => {
  const { stream_id } = req.query;
  if (!stream_id)
    return res.status(400).json({ message: "Stream ID is required" });

  try {
    const [subjects] = await db.query(
      "SELECT id, name FROM subjects WHERE stream_id = ?",
      [stream_id]
    );

    const data = [];

    for (const subj of subjects) {
      const [categories] = await db.query(
        "SELECT id, name FROM categories WHERE subject_id = ?",
        [subj.id]
      );
      for (const cat of categories) {
        const [chapters] = await db.query(
          "SELECT id, name FROM chapters WHERE category_id = ?",
          [cat.id]
        );
        for (const chap of chapters) {
          const [counts] = await db.query(
            `SELECT level AS difficulty, COUNT(*) AS total
             FROM questions
             WHERE subject_id=? AND category_id=? AND chapter_id=?
             GROUP BY level`,
            [subj.id, cat.id, chap.id]
          );

          const stats = {
            subject: subj.name,
            category: cat.name,
            chapter: chap.name,
            easy: 0,
            medium: 0,
            hard: 0,
          };
          counts.forEach((r) => (stats[r.difficulty] = r.total));
          stats.total = stats.easy + stats.medium + stats.hard;
          data.push(stats);
        }
      }
    }

    res.json({ stream_id, distribution: data });
  } catch (err) {
    console.error("❌ Preview error:", err);
    res.status(500).json({ error: "Failed to generate preview" });
  }
});

/* ============================================================
   ✅ GET ALL BALANCED TESTS
   GET /admin/tests
   ============================================================ */
router.get("/", async (req, res) => {
  try {
    const [tests] = await db.query(`
      SELECT 
        t.id,
        t.name,
        s.name AS stream_name,
        t.total_questions,
        t.created_at
      FROM tests t
      LEFT JOIN streams s ON t.stream_id = s.id
      ORDER BY t.created_at DESC
    `);

    res.json({ tests });
  } catch (err) {
    console.error("❌ Error fetching balanced tests:", err);
    res.status(500).json({ error: "Failed to fetch balanced tests" });
  }
});

export default router;
