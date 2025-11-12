
import express from "express";
import db from "../../db.js";

const router = express.Router();

/**
 * 📊 GET /admin/reports/test/:test_id
 * Returns detailed performance report for a specific test,
 * including subject-wise and chapter-wise analysis.
 */
router.get("/test/:test_id", async (req, res) => {
  const { test_id } = req.params;

  try {
    // 🧩 1. Fetch test info
    const [testRows] = await db.query(
      `SELECT 
         t.id, t.name, t.total_questions, 
         s.name AS stream_name
       FROM tests t
       LEFT JOIN streams s ON s.id = t.stream_id
       WHERE t.id = ?`,
      [test_id]
    );

    if (!testRows.length)
      return res.status(404).json({ error: "Test not found" });

    const test = testRows[0];

    // 👩‍🎓 2. Student performance summary
    const [studentRows] = await db.query(
      `SELECT 
         st.id AS student_id,
         st.name AS student_name,
         COUNT(DISTINCT a.question_id) AS attempted,
         SUM(CASE WHEN a.is_correct = 1 THEN 1 ELSE 0 END) AS correct,
         ROUND((SUM(CASE WHEN a.is_correct = 1 THEN 1 ELSE 0 END) / t.total_questions) * 100, 2) AS percentage,
         TIME_TO_SEC(TIMEDIFF(MAX(a.submitted_at), MIN(a.started_at))) / 60 AS time_taken
       FROM student_answers a
       JOIN students st ON st.id = a.student_id
       JOIN tests t ON t.id = a.test_id
       WHERE a.test_id = ?
       GROUP BY st.id
       ORDER BY percentage DESC, time_taken ASC`,
      [test_id]
    );

    // 🏆 Add rank
    const students = studentRows.map((r, index) => ({
      ...r,
      rank: index + 1,
      time_taken: r.time_taken ? Math.round(r.time_taken) : 0,
    }));

    // 📚 3. Subject-wise performance (for all students)
    const [subjectStats] = await db.query(
      `SELECT 
         sub.name AS subject_name,
         COUNT(DISTINCT q.id) AS total_questions,
         SUM(a.is_correct) AS total_correct,
         ROUND((SUM(a.is_correct) / COUNT(q.id)) * 100, 2) AS avg_accuracy
       FROM questions q
       JOIN subjects sub ON q.subject_id = sub.id
       LEFT JOIN student_answers a ON a.question_id = q.id AND a.test_id = ?
       WHERE q.test_id = ?
       GROUP BY sub.id
       ORDER BY sub.name`,
      [test_id, test_id]
    );

    // 📘 4. Chapter-wise performance (optional deeper insight)
    const [chapterStats] = await db.query(
      `SELECT 
         c.name AS chapter_name,
         sub.name AS subject_name,
         COUNT(DISTINCT q.id) AS total_questions,
         SUM(a.is_correct) AS total_correct,
         ROUND((SUM(a.is_correct) / COUNT(q.id)) * 100, 2) AS avg_accuracy
       FROM questions q
       JOIN chapters c ON q.chapter_id = c.id
       JOIN subjects sub ON q.subject_id = sub.id
       LEFT JOIN student_answers a ON a.question_id = q.id AND a.test_id = ?
       WHERE q.test_id = ?
       GROUP BY c.id, sub.id
       ORDER BY sub.name, c.name`,
      [test_id, test_id]
    );

    // ✅ Final combined report
    res.json({
      test,
      summary: {
        total_students: students.length,
        average_percentage: (
          students.reduce((sum, s) => sum + s.percentage, 0) /
          (students.length || 1)
        ).toFixed(2),
      },
      students,
      subject_stats: subjectStats,
      chapter_stats: chapterStats,
    });
  } catch (err) {
    console.error("❌ Error generating admin report:", err);
    res.status(500).json({ error: "Failed to generate admin report." });
  }
});


export default router;
