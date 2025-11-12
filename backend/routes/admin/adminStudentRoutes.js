import express from "express";
import pool from "../../db.js";

const router = express.Router();

// ----------------------
// Get all students (with stream name)
// ----------------------
router.get("/", async (req, res) => {
  try {
    const [rows] = await pool.query(`
      SELECT s.*, st.name AS stream_name
      FROM students s
      LEFT JOIN streams st ON s.stream_id = st.id
      ORDER BY s.id DESC
    `);
    res.json({ students: rows });
  } catch (err) {
    console.error("Error fetching students:", err);
    res.status(500).json({ error: "Failed to fetch students" });
  }
});

// ----------------------
// Add a new student
// ----------------------
router.post("/", async (req, res) => {
  const { name, email, mobile, city, stream_id } = req.body;
  if (!name || !email || !mobile || !city || !stream_id)
    return res.status(400).json({ error: "All fields are required" });

  try {
    // Check for duplicate email
    const [existing] = await pool.query(
      "SELECT * FROM students WHERE email = ?",
      [email]
    );
    if (existing.length > 0)
      return res.status(400).json({ error: "Email already exists" });

    // Verify stream_id exists
    const [streamExists] = await pool.query(
      "SELECT id FROM streams WHERE id = ?",
      [stream_id]
    );
    if (streamExists.length === 0)
      return res.status(400).json({ error: "Invalid stream selected" });

    // Insert student
    await pool.query(
      "INSERT INTO students (name, email, mobile, city, stream_id) VALUES (?, ?, ?, ?, ?)",
      [name, email, mobile, city, stream_id]
    );

    res.json({ message: "Student added successfully" });
  } catch (err) {
    console.error("Error adding student:", err);
    res.status(500).json({ error: "Failed to add student" });
  }
});

// ----------------------
// Update student
// ----------------------
// ----------------------
// Update student
// ----------------------
router.put("/:id", async (req, res) => {
  const { id } = req.params;
  const { name, email, mobile, city, stream } = req.body;

  try {
    await pool.query(
      "UPDATE students SET name=?, email=?, mobile=?, city=?, stream=? WHERE id=?",
      [name, email, mobile, city, stream, id]
    );
    res.json({ message: "Student updated successfully" });
  } catch (err) {
    console.error("Error updating student:", err);
    res.status(500).json({ error: "Failed to update student" });
  }
});


// ----------------------
// Delete student
// ----------------------
router.delete("/:id", async (req, res) => {
  const { id } = req.params;
  try {
    await pool.query("DELETE FROM students WHERE id = ?", [id]);
    res.json({ message: "Student deleted successfully" });
  } catch (err) {
    console.error("Error deleting student:", err);
    res.status(500).json({ error: "Failed to delete student" });
  }
});

export default router;
