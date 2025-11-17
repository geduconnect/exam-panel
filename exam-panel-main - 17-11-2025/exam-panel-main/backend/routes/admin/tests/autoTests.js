import express from "express";
import pool from "../../../db.js";

const router = express.Router();

// POST /admin/tests/create-balanced
router.post("/create-balanced", async (req, res) => {
  try {
    const { stream_id, questionsPerLevel = 2, testName, duration = 60 } = req.body;

    if (!stream_id || !testName)
      return res.status(400).json({ message: "Stream and test name are required" });

    // Fetch chapters under the stream
    const [chapters] = await pool.query(
      `SELECT id, name FROM chapters WHERE stream_id = ?`,
      [stream_id]
    );

    if (!chapters.length)
      return res.status(400).json({ message: "No chapters found for this stream" });

    const levels = ["easy", "medium", "hard"];
    let selectedQuestions = [];

    // Loop through each chapter and level
    for (const chapter of chapters) {
      for (const level of levels) {
        const [questions] = await pool.query(
          `SELECT id FROM questions 
           WHERE chapter_id = ? AND level = ?
           ORDER BY RAND()
           LIMIT ?`,
          [chapter.id, level, questionsPerLevel]
        );

        selectedQuestions.push(...questions.map((q) => q.id));
      }
    }

    if (!selectedQuestions.length)
      return res.status(400).json({ message: "No questions found for this stream" });

    // Insert test record
    const [result] = await pool.query(
      `INSERT INTO tests (test_name, stream_id, question_ids, duration, created_at)
       VALUES (?, ?, ?, ?, NOW())`,
      [testName, stream_id, JSON.stringify(selectedQuestions), duration]
    );

    res.json({
      message: "✅ Balanced test created successfully",
      test_id: result.insertId,
      testName,
      duration,
      totalQuestions: selectedQuestions.length,
    });
  } catch (err) {
    console.error("❌ Error creating balanced test:", err);
    res.status(500).json({ message: "Internal Server Error" });
  }
});

export default router;
