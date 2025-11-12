import express from "express";
import pool from "../../../db.js"; // or db, depending on your naming

const router = express.Router();

/**
 * ✅ Get all questions for a specific test (with subject/category/chapter info)
 * Endpoint: GET /admin/tests/:id/questions
 */
router.get("/:id/questions", async (req, res) => {
  const { id } = req.params;

  try {
    const [rows] = await pool.query(
      `
      SELECT 
        q.id, 
        q.question, 
        q.option_a, 
        q.option_b, 
        q.option_c, 
        q.option_d, 
        q.correct_answer AS answer, 
        q.explanation, 
        q.level,
        s.name AS subject_name, 
        c.name AS category_name, 
        ch.name AS chapter_name
      FROM test_questions tq
      JOIN questions q ON tq.question_id = q.id
      LEFT JOIN subjects s ON q.subject_id = s.id
      LEFT JOIN categories c ON q.category_id = c.id
      LEFT JOIN chapters ch ON q.chapter_id = ch.id
      WHERE tq.test_id = ?
      ORDER BY q.level, q.id
      `,
      [id]
    );

    if (rows.length === 0) {
      return res.status(404).json({ message: "No questions found for this test." });
    }

    res.json({
      test_id: id,
      total_questions: rows.length,
      questions: rows,
    });
  } catch (err) {
    console.error("❌ Error fetching test questions:", err);
    res.status(500).json({ error: "Failed to load test questions" });
  }
});

export default router;
