import express from "express";
import db from "../../../db.js";
const router = express.Router();

// ✅ Get all created tests
router.get("/list", async (req, res) => {
  try {
    const [tests] = await db.query(`
    SELECT 
  t.id, 
  t.name, 
  t.stream_id,
  t.total_questions,
  t.randomize,
  s.name AS stream_name,
  ta.assigned_to,
  ta.assigned_id,
  t.created_at
FROM tests t
LEFT JOIN streams s ON t.stream_id = s.id
LEFT JOIN test_assignments ta ON ta.test_id = t.id
ORDER BY t.id DESC

    `);

    res.json({ tests });
  } catch (err) {
    console.error("❌ Error fetching test list:", err);
    res.status(500).json({ error: "Failed to fetch tests" });
  }
});

// ✅ Delete test
router.delete("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    await db.query("DELETE FROM tests WHERE id = ?", [id]);
    res.json({ success: true });
  } catch (err) {
    console.error("❌ Error deleting test:", err);
    res.status(500).json({ error: "Failed to delete test" });
  }
});

export default router;
