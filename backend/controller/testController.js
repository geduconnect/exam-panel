import pool from "../db.js";

// Fisher–Yates shuffle
function shuffle(array) {
  for (let i = array.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [array[i], array[j]] = [array[j], array[i]];
  }
  return array;
}

// ✅ Create test with hierarchy-based distribution
export const createTest = async (req, res) => {
  const conn = await pool.getConnection();
  try {
    const {
      name,
      stream_id,
      total_questions,
      duration = 90,
      randomize = true,
      assigned_to, // 'batch' | 'stream' | 'student'
      assigned_id,
    } = req.body;

    if (!name || !stream_id || !total_questions)
      return res.status(400).json({ error: "Missing required fields" });

    // Begin transaction
    await conn.beginTransaction();

    // Create test record
    const [testResult] = await conn.query(
      `INSERT INTO tests (name, stream_id, duration, total_questions, randomize, created_at)
       VALUES (?, ?, ?, ?, ?, NOW())`,
      [name, stream_id, duration, total_questions, randomize ? 1 : 0]
    );
    const test_id = testResult.insertId;

    // Assign test
    if (assigned_to && assigned_id) {
      await conn.query(
        `INSERT INTO test_assignments (test_id, assigned_to, assigned_id)
         VALUES (?, ?, ?)`,
        [test_id, assigned_to, assigned_id]
      );
    }

    // --- Hierarchy logic ---
    const [subjects] = await conn.query(
      "SELECT id FROM subjects WHERE stream_id = ?",
      [stream_id]
    );

    if (subjects.length === 0)
      throw new Error("No subjects found under this stream.");

    const perSubject = Math.floor(total_questions / subjects.length);
    let selectedQuestions = [];

    for (const subj of subjects) {
      const [categories] = await conn.query(
        "SELECT id FROM categories WHERE subject_id = ?",
        [subj.id]
      );
      const perCategory = Math.max(1, Math.floor(perSubject / categories.length));

      for (const cat of categories) {
        const [chapters] = await conn.query(
          "SELECT id FROM chapters WHERE category_id = ?",
          [cat.id]
        );
        const perChapter = Math.max(1, Math.floor(perCategory / chapters.length));

        for (const chap of chapters) {
          const [subcats] = await conn.query(
            "SELECT id FROM subcategories WHERE chapter_id = ?",
            [chap.id]
          );
          const perSub = Math.max(1, Math.floor(perChapter / (subcats.length || 1)));

          for (const sc of subcats) {
            const [qset] = await conn.query(
              `SELECT id FROM questions WHERE subcategory_id = ? ORDER BY RAND() LIMIT ?`,
              [sc.id, perSub]
            );
            selectedQuestions.push(...qset);
          }
        }
      }
    }

    // Randomize globally if enabled
    if (randomize) selectedQuestions = shuffle(selectedQuestions);

    // Insert test questions
    if (selectedQuestions.length === 0)
      throw new Error("No questions found to generate test.");

    const tqValues = selectedQuestions.map((q, index) => [test_id, q.id, index + 1]);
    await conn.query(
      "INSERT INTO test_questions (test_id, question_id, sequence) VALUES ?",
      [tqValues]
    );

    await conn.commit();
    res.json({
      message: "✅ Test generated successfully",
      test_id,
      totalQuestions: selectedQuestions.length,
    });
  } catch (err) {
    await conn.rollback();
    console.error("❌ Error creating test:", err);
    res.status(500).json({ error: err.message || "Failed to create test" });
  } finally {
    conn.release();
  }
};

// ✅ Get test questions for student/test preview
export const getTestQuestions = async (req, res) => {
  try {
    const { test_id } = req.params;
    const [rows] = await pool.query(
      `SELECT tq.sequence, q.*
       FROM test_questions tq
       JOIN questions q ON tq.question_id = q.id
       WHERE tq.test_id = ?
       ORDER BY tq.sequence ASC`,
      [test_id]
    );
    res.json(rows);
  } catch (err) {
    console.error("❌ Error fetching test questions:", err);
    res.status(500).json({ error: "Failed to fetch test questions" });
  }
};
