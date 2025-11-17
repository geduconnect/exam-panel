import express from "express";
import pool from "../../../db.js";

const router = express.Router();

/* ===========================================================
   📘 1️⃣ TEST OVERVIEW – All Tests (Summary)
   =========================================================== */
router.get("/admin/test-overview", async (req, res) => {
  try {
    const [tests] = await pool.query(`
      SELECT 
        t.id AS test_id,
        t.name AS test_name,
        s.name AS stream_name,
        COUNT(tr.id) AS total_attempts,
        ROUND(AVG((tr.score / tr.total_questions) * 100), 2) AS avg_percentage,
        MAX((tr.score / tr.total_questions) * 100) AS highest_percentage,
        MIN((tr.score / tr.total_questions) * 100) AS lowest_percentage
      FROM tests t
      LEFT JOIN streams s ON t.stream_id = s.id
      LEFT JOIN test_results tr ON t.id = tr.test_id
      GROUP BY t.id, t.name, s.name
      ORDER BY t.created_at DESC
    `);

    const enrichedTests = await Promise.all(
      tests.map(async (test) => {
        const [[best]] = await pool.query(
          `
          SELECT st.name AS student_name, 
                 ROUND((tr.score / tr.total_questions) * 100, 2) AS percentage
          FROM test_results tr
          JOIN students st ON tr.student_id = st.id
          WHERE tr.test_id = ?
          ORDER BY percentage DESC
          LIMIT 1
          `,
          [test.test_id]
        );

        return {
          ...test,
          best_student: best?.student_name || null,
          best_score: best?.percentage || null,
        };
      })
    );

    res.json({ overview: enrichedTests });
  } catch (err) {
    console.error("❌ Error fetching test overview:", err);
    res.status(500).json({ error: "Failed to load test overview" });
  }
});

/* ===========================================================
   📊 2️⃣ TEST SUMMARY – Student-Wise Results for a Specific Test
   =========================================================== */
router.get("/admin/test-summary", async (req, res) => {
  const { test_id } = req.query;

  if (!test_id)
    return res.status(400).json({ error: "Missing test_id parameter" });

  try {
    const [testRows] = await pool.query(
      `
      SELECT 
        t.id AS test_id,
        t.name AS test_name,
        t.assigned_to,
        t.assigned_id,
        CASE 
          WHEN t.assigned_to = 'stream' THEN s.name
          WHEN t.assigned_to = 'student' THEN st.name
          ELSE 'N/A'
        END AS assigned_name
      FROM tests t
      LEFT JOIN streams s ON t.assigned_to = 'stream' AND t.assigned_id = s.id
      LEFT JOIN students st ON t.assigned_to = 'student' AND t.assigned_id = st.id
      WHERE t.id = ?
      `,
      [test_id]
    );

    if (!testRows.length)
      return res.status(404).json({ error: "Test not found" });

    const test = testRows[0];

    // 🧩 Student-wise performance
    const [studentResults] = await pool.query(
      `
      SELECT 
        st.name AS student_name,
        tr.score AS total_marks,
        ROUND((tr.score / tr.total_questions) * 100, 2) AS percentage,
        CASE 
          WHEN (tr.score / tr.total_questions) * 100 >= 85 THEN 'Excellent'
          WHEN (tr.score / tr.total_questions) * 100 >= 70 THEN 'Good'
          WHEN (tr.score / tr.total_questions) * 100 >= 50 THEN 'Average'
          ELSE 'Needs Improvement'
        END AS performance
      FROM test_results tr
      JOIN students st ON tr.student_id = st.id
      WHERE tr.test_id = ?
      ORDER BY percentage DESC
      `,
      [test_id]
    );

    const total_attempts = studentResults.length;
    const percentages = studentResults.map((r) => Number(r.percentage));

    const avg_percentage =
      percentages.length > 0
        ? (percentages.reduce((a, b) => a + b, 0) / percentages.length).toFixed(
            2
          )
        : 0;

    const highest_score = percentages.length ? Math.max(...percentages) : 0;
    const lowest_score = percentages.length ? Math.min(...percentages) : 0;

    res.json({
      summary: {
        test_id: test.test_id,
        test_name: test.test_name,
        assigned_to: test.assigned_to,
        assigned_name: test.assigned_name,
        total_attempts,
        avg_percentage,
        highest_score,
        lowest_score,
      },
      students: studentResults,
    });
  } catch (err) {
    console.error("❌ Error generating summary:", err);
    res.status(500).json({ error: "Database error" });
  }
});

/* ===========================================================
   📚 3️⃣ SUBJECT / CHAPTER BREAKDOWN (Optional Enhancement)
   =========================================================== */
router.get("/admin/test-analysis/:test_id", async (req, res) => {
  const { test_id } = req.params;
  try {
    const [subjectStats] = await pool.query(
      `
      SELECT 
        sub.name AS subject_name,
        COUNT(DISTINCT q.id) AS total_questions,
        SUM(CASE WHEN sa.is_correct = 1 THEN 1 ELSE 0 END) AS total_correct,
        ROUND((SUM(CASE WHEN sa.is_correct = 1 THEN 1 ELSE 0 END) / COUNT(DISTINCT q.id)) * 100, 2) AS accuracy
      FROM questions q
      JOIN subjects sub ON q.subject_id = sub.id
      LEFT JOIN student_answers sa ON sa.question_id = q.id AND sa.test_id = ?
      WHERE q.test_id = ?
      GROUP BY sub.id
      ORDER BY sub.name
      `,
      [test_id, test_id]
    );

    const [chapterStats] = await pool.query(
      `
      SELECT 
        c.name AS chapter_name,
        sub.name AS subject_name,
        COUNT(DISTINCT q.id) AS total_questions,
        SUM(CASE WHEN sa.is_correct = 1 THEN 1 ELSE 0 END) AS total_correct,
        ROUND((SUM(CASE WHEN sa.is_correct = 1 THEN 1 ELSE 0 END) / COUNT(DISTINCT q.id)) * 100, 2) AS accuracy
      FROM questions q
      JOIN subjects sub ON q.subject_id = sub.id
      JOIN chapters c ON q.chapter_id = c.id
      LEFT JOIN student_answers sa ON sa.question_id = q.id AND sa.test_id = ?
      WHERE q.test_id = ?
      GROUP BY c.id, sub.id
      ORDER BY sub.name, c.name
      `,
      [test_id, test_id]
    );

    res.json({
      subjects: subjectStats,
      chapters: chapterStats,
    });
  } catch (err) {
    console.error("❌ Error generating test analysis:", err);
    res.status(500).json({ error: "Failed to generate test analysis" });
  }
});

export default router;
