import bcrypt from "bcrypt";
import express from "express";
import pool from "../../db.js";
import {
  adminLogin,
  addAdminUser,
  getAllAdminUsers,
  adminLogout,

} from "../../controller/adminController.js";
import {
  requireLogin,
  requireSuperAdmin,
} from "../../middleware/authMiddleware.js";

const router = express.Router();

// ------------------------
// Admin Login
// ------------------------
router.post("/login", adminLogin);


// ------------------------
// Add Admin User (Super Admin Only)
// ------------------------
router.post("/add-user", requireLogin, requireSuperAdmin, addAdminUser);

// ------------------------
// Get All Admin Users
// ------------------------
router.get("/users", requireLogin, requireSuperAdmin, getAllAdminUsers);

// ------------------------
// Student Management Routes
// ------------------------

// Get all students
router.get("/students", requireLogin, async (req, res) => {
  try {
 const [rows] = await pool.query(`
  SELECT 
    s.id, 
    s.name, 
    s.email, 
    s.mobile, 
    s.city, 
    st.name AS stream,  -- ✅ join with streams table
    s.created_at
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

// Add new student
router.post("/students", requireLogin, async (req, res) => {
  const { name, email, mobile, city, stream, password } = req.body;
  if (!name || !email || !mobile || !city || !stream || !password) {
    return res.status(400).json({ error: "All fields are required" });
  }
  try {
    const [existing] = await pool.query(
      "SELECT * FROM students WHERE email = ?",
      [email]
    );
    if (existing.length > 0) {
      return res.status(400).json({ error: "Email already registered" });
    }

    const hashed = await bcrypt.hash(password, 10);
    await pool.query(
      "INSERT INTO students (name, email, mobile, city, stream, password) VALUES (?, ?, ?, ?, ?, ?)",
      [name, email, mobile, city, stream, hashed]
    );
    res.json({ message: "Student added successfully" });
  } catch (err) {
    console.error("Error adding student:", err);
    res.status(500).json({ error: "Failed to add student" });
  }
});

// Update student
router.put("/students/:id", async (req, res) => {
  const { id } = req.params;
  const { name, email, mobile, city, stream_id } = req.body; // ✅ use stream_id

  try {
    await pool.query(
      "UPDATE students SET name=?, email=?, mobile=?, city=?, stream_id=? WHERE id=?",
      [name, email, mobile, city, stream_id, id]
    );
    res.json({ message: "Student updated successfully" });
  } catch (err) {
    console.error("Error updating student:", err);
    res.status(500).json({ error: "Failed to update student" });
  }
});
router.put("/students/:id/reset-password", requireLogin, async (req, res) => {
  const { id } = req.params;
  const { password } = req.body;

  try {
    const hashed = await bcrypt.hash(password, 10);

    // ✅ Update password in MySQL
    await pool.query("UPDATE students SET password = ? WHERE id = ?", [
      hashed,
      id,
    ]);

    res.json({ message: "Password reset successful" });
  } catch (err) {
    console.error("Error resetting password:", err);
    res.status(500).json({ error: "Server error while resetting password" });
  }
});
// Delete student
router.delete("/students/:id", requireLogin, async (req, res) => {
  const { id } = req.params;
  try {
    await pool.query("DELETE FROM students WHERE id=?", [id]);
    res.json({ message: "Student deleted successfully" });
  } catch (err) {
    console.error("Error deleting student:", err);
    res.status(500).json({ error: "Failed to delete student" });
  }
});

// ------------------------
// Admin Logout
// ------------------------
router.post("/logout", requireLogin, adminLogout);

export default router;
