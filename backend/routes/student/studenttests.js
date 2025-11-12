import express from "express";
import pool from "../../db.js";

const router = express.Router();

// ✅ Resume test or load new one
router.get("/:subjectId/resume", async (req, res) => {
  const { subjectId } = req.params;
  try {
    // Fetch random test or active test for this subject
    const [test] = await pool.query(
      "SELECT id, name, total_questions FROM tests WHERE subject_id = ? LIMIT 1",
      [subjectId]
    );

    if (!test.length) {
      return res.status(404).json({ message: "No test found for this subject" });
    }

    const testId = test[0].id;

    // Fetch questions for that test
    const [questions] = await pool.query(
      `SELECT id, question, option_a, option_b, option_c, option_d, subject_id 
       FROM questions WHERE test_id = ? LIMIT ?`,
      [testId, test[0].total_questions || 10]
    );

    res.json({
      questions,
      savedAnswers: {}, // Later you can load from pool if you want resume feature
      remainingTime: 1200, // default 20 minutes
    });
  } catch (err) {
    console.error("❌ Error fetching test data:", err);
    res.status(500).json({ message: "Server error" });
  }
});

// ✅ Auto-save answers
router.post("/:subjectId/autosave", async (req, res) => {
  try {
    // Here you can save answers & remaining time in pool
    res.json({ success: true });
  } catch (err) {
    console.error("❌ Auto-save error:", err);
    res.status(500).json({ message: "Failed to save progress" });
  }
});

// ✅ Submit test
router.post("/:subjectId/submit", async (req, res) => {
  try {
    const { answers } = req.body;
    // In production, calculate score here and save to pool
    console.log("✅ Student submitted answers:", answers);
    res.json({ message: "Test submitted successfully!" });
  } catch (err) {
    console.error("❌ Submit error:", err);
    res.status(500).json({ message: "Failed to submit test" });
  }
});

export default router;
