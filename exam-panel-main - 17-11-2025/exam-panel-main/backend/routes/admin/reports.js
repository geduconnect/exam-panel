import express from "express";
import pool from "../../db.js";

const router = express.Router();

// ✅ GET test report for admin
router.get("/test/:test_id", async (req, res) => {

  const { test_id } = req.query;
  if (!test_id) return res.status(400).json({ error: "Missing test_id" });

  try {
    // 🟩 Subject-wise performance for all students
    const [subjectwise] = await pool.query(
      `SELECT 
         s.name AS subject_name,
         COUNT(q.id) AS total_questions,
         SUM(
           CASE 
             WHEN sa.answer IS NOT NULL 
              AND LOWER(TRIM(sa.answer)) = LOWER(TRIM(q.correct_answer))
             THEN 1 ELSE 0 END
         ) AS total_correct,
         ROUND(
           SUM(
             CASE 
               WHEN sa.answer IS NOT NULL 
                AND LOWER(TRIM(sa.answer)) = LOWER(TRIM(q.correct_answer))
               THEN 1 ELSE 0 END
           ) / COUNT(q.id) * 100, 2
         ) AS avg_accuracy
       FROM student_answers sa
       JOIN questions q ON sa.question_id = q.id
       LEFT JOIN subjects s ON q.subject_id = s.id
       WHERE sa.test_id = ?
       GROUP BY s.id, s.name
       ORDER BY s.name`,
      [test_id]
    );

    // 🟩 Chapter-wise performance (optional)
    const [chapterwise] = await pool.query(
      `SELECT 
         s.name AS subject_name,
         c.name AS chapter_name,
         COUNT(q.id) AS total,
         SUM(
           CASE 
             WHEN sa.answer IS NOT NULL 
              AND LOWER(TRIM(sa.answer)) = LOWER(TRIM(q.correct_answer))
             THEN 1 ELSE 0 END
         ) AS correct,
         ROUND(
           SUM(
             CASE 
               WHEN sa.answer IS NOT NULL 
                AND LOWER(TRIM(sa.answer)) = LOWER(TRIM(q.correct_answer))
               THEN 1 ELSE 0 END
           ) / COUNT(q.id) * 100, 2
         ) AS accuracy
       FROM student_answers sa
       JOIN questions q ON sa.question_id = q.id
       LEFT JOIN subjects s ON q.subject_id = s.id
       LEFT JOIN chapters c ON q.chapter_id = c.id
       WHERE sa.test_id = ?
       GROUP BY s.id, c.id
       ORDER BY s.name, c.name`,
      [test_id]
    );

    res.json({ subjectwise, chapterwise });
  } catch (err) {
    console.error("❌ Error generating admin report:", err);
    res.status(500).json({ error: "Failed to generate admin report." });
  }
});
export default router;
