import express from "express";
import pool from "../../../db.js";

const router = express.Router();

// ✅ Create test
router.post("/", async (req, res) => {
  const { name, total_duration, randomize_within_chapter } = req.body;
  try {
    const [result] = await pool.query(
      "INSERT INTO tests (name, total_duration, randomize_within_chapter) VALUES (?, ?, ?)",
      [name, total_duration, randomize_within_chapter]
    );
    res.json({ success: true, test_id: result.insertId });
  } catch (err) {
    console.error("❌ Error creating test:", err);
    res.status(500).json({ error: "Failed to create test" });
  }
});

// ✅ Generate test sets automatically
router.post("/:id/generate-sets", async (req, res) => {
  const { id } = req.params;
  const { setCount } = req.body; // e.g. 3 sets => A,B,C

  try {
    const setNames = ["A", "B", "C", "D", "E"].slice(0, setCount);
    for (const name of setNames) {
      await pool.query("INSERT INTO test_sets (test_id, set_name) VALUES (?, ?)", [id, name]);
    }
    res.json({ success: true, message: `${setCount} sets created.` });
  } catch (err) {
    console.error("❌ Error generating sets:", err);
    res.status(500).json({ error: "Set generation failed" });
  }
});

// ✅ Auto-pick questions for each subject in test
router.post("/:id/populate-questions", async (req, res) => {
  const { id } = req.params;
  try {
    // Get all test sets
    const [sets] = await pool.query("SELECT * FROM test_sets WHERE test_id = ?", [id]);

    for (const set of sets) {
      // Pick 10 Easy, 10 Medium, 10 Hard per subject
      const levels = ["easy", "medium", "hard"];
      for (const level of levels) {
        const [questions] = await pool.query(
          `SELECT id FROM questions WHERE level = ? ORDER BY RAND() LIMIT 10`,
          [level]
        );
        for (const q of questions) {
          await pool.query("INSERT INTO test_questions (set_id, question_id) VALUES (?, ?)", [
            set.id,
            q.id,
          ]);
        }
      }
    }

    res.json({ success: true, message: "Questions populated successfully" });
  } catch (err) {
    console.error("❌ Error populating questions:", err);
    res.status(500).json({ error: "Failed to populate test" });
  }
});

export default router;
