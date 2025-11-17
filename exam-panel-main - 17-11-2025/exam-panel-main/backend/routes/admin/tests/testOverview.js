import express from "express";
import db from "../../../db.js";

const router = express.Router();

// ✅ Fetch overall test overview for admin dashboard
router.get("/test-overview", async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT 
        t.id AS test_id,
        t.name AS test_name,
        s.name AS stream_name,
        COUNT(r.id) AS total_attempts,
        ROUND(AVG(r.percentage), 2) AS avg_percentage,
        MAX(r.percentage) AS highest_percentage,
        MIN(r.percentage) AS lowest_percentage,
        (
          SELECT st.name 
          FROM results r2
          JOIN students st ON r2.student_id = st.id
          WHERE r2.test_id = t.id
          ORDER BY r2.percentage DESC
          LIMIT 1
        ) AS best_student
      FROM tests t
      LEFT JOIN streams s ON s.id = t.stream_id
      LEFT JOIN results r ON r.test_id = t.id
      GROUP BY t.id
      ORDER BY t.id DESC
    `);

    res.json({ overview: rows });
  } catch (err) {
    console.error("❌ Error fetching test overview:", err);
    res.status(500).json({ error: "Failed to load test overview" });
  }
});

export default router;
