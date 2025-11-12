import express from "express";
import db from "../../../db.js";

const router = express.Router();
const shuffle = (arr) => arr.sort(() => Math.random() - 0.5);

// ✅ Create balanced test
router.post("/create-balanced", async (req, res) => {
  try {
    const {
      stream_id,
      streamId,
      total_questions,
      totalQuestions,
      name,
      randomize,
      assigned_to,
      assignedTo,
      assigned_id,
      assignedId,
    } = req.body;

    // ✅ Normalize incoming values
    const finalStreamId = Number(stream_id || streamId);
    const finalTotalQuestions = Number(total_questions || totalQuestions);
    const finalAssignedTo = assigned_to || assignedTo;
    const finalAssignedId = assigned_id || assignedId;

    console.log("📩 Incoming request:", {
      name,
      finalStreamId,
      finalTotalQuestions,
      randomize,
      finalAssignedTo,
      finalAssignedId,
    });

    // ✅ Validation
    if (!finalStreamId || !name?.trim()) {
      return res
        .status(400)
        .json({ message: "Stream ID and test name are required" });
    }

    // ✅ Step 1: Fetch subjects
    const [subjects] = await db.query(
      "SELECT id FROM subjects WHERE stream_id=?",
      [finalStreamId]
    );
    if (!subjects.length) {
      return res
        .status(404)
        .json({ error: "No subjects found for this stream" });
    }

    // ✅ Step 2: Build hierarchy (subject → category → chapter)
    const hierarchy = [];
    for (const subj of subjects) {
      const [categories] = await db.query(
        "SELECT id FROM categories WHERE subject_id=?",
        [subj.id]
      );
      for (const cat of categories) {
        const [chapters] = await db.query(
          "SELECT id FROM chapters WHERE category_id=?",
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

    if (!hierarchy.length) {
      return res
        .status(404)
        .json({ error: "No chapters found for this stream" });
    }

    // ✅ Step 3: Select questions evenly per difficulty level
    const perUnit = Math.floor(finalTotalQuestions / hierarchy.length);
    const difficulties = ["easy", "medium", "hard"];
    const selected = [];

    for (const unit of hierarchy) {
      for (const diff of difficulties) {
        const [qs] = await db.query(
          `SELECT id FROM questions 
           WHERE subject_id=? AND category_id=? AND chapter_id=? AND level=? 
           ORDER BY RAND() LIMIT ?`,
          [
            unit.subject_id,
            unit.category_id,
            unit.chapter_id,
            diff,
            Math.max(1, Math.floor(perUnit / 3)), // avoid zero-limit queries
          ]
        );
        selected.push(...qs.map((q) => q.id));
      }
    }

    if (!selected.length) {
      return res.status(404).json({
        success: false,
        message: "No questions found for the selected stream and chapters",
      });
    }

    const finalQuestions = randomize ? shuffle(selected) : selected;

    const [testRes] = await db.query(
      "INSERT INTO tests (name, stream_id, total_questions, randomize) VALUES (?, ?, ?, ?)",
      [name, finalStreamId, finalTotalQuestions, randomize]
    );

    const test_id = testRes.insertId;
    // ✅ Step 5: Link questions
    const values = finalQuestions.map((id) => [test_id, id]);
    await db.query(
      "INSERT INTO test_questions (test_id, question_id) VALUES ?",
      [values]
    );

    // ✅ Step 6: Assign test (if applicable)
    if (finalAssignedTo && finalAssignedId) {
      await db.query(
        "INSERT INTO test_assignments (test_id, assigned_to, assigned_id) VALUES (?, ?, ?)",
        [test_id, finalAssignedTo, finalAssignedId]
      );
    }

    console.log("✅ Test created:", {
      test_id,
      total: finalQuestions.length,
    });

    res.json({
      success: true,
      message: "✅ Balanced test created successfully",
      test_id,
      total_questions: finalQuestions.length,
    });
  } catch (err) {
    console.error("❌ Error generating test:", err);
    res.status(500).json({ error: "Error generating balanced test" });
  }
});

// ✅ Preview question distribution per difficulty
router.get("/preview", async (req, res) => {
  const { stream_id } = req.query;
  if (!stream_id) {
    console.log("⚠️ Missing stream_id in preview");
    return res.status(400).json({ message: "Stream ID is required" });
  }

  try {
    const [subjects] = await db.query(
      "SELECT id, name FROM subjects WHERE stream_id=?",
      [stream_id]
    );
    const data = [];

    for (const subj of subjects) {
      const [categories] = await db.query(
        "SELECT id, name FROM categories WHERE subject_id=?",
        [subj.id]
      );
      for (const cat of categories) {
        const [chapters] = await db.query(
          "SELECT id, name FROM chapters WHERE category_id=?",
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
router.get("/", async (req, res) => {
  try {
    const [tests] = await db.query(`
      SELECT 
        t.id,
        t.name,
        s.name AS stream_name,
        subj.name AS subject_name,
        t.total_questions,
        t.created_at
      FROM tests t
      LEFT JOIN streams s ON t.stream_id = s.id
      LEFT JOIN subjects subj ON subj.stream_id = s.id
      ORDER BY t.created_at DESC
    `);

    res.json({ tests });
  } catch (err) {
    console.error("❌ Error fetching balanced tests:", err);
    res.status(500).json({ error: "Failed to fetch balanced tests" });
  }
});

export default router;
