// controllers/student/studentController.js
import pool from "../../db.js";
import bcrypt from "bcrypt";

// ------------------------
// Register Student
// ------------------------
export const registerStudent = async (req, res) => {
  try {
    const { name, email, password } = req.body;

    if (!name || !email || !password)
      return res.status(400).json({ error: "All fields are required" });

    const [existing] = await pool.query("SELECT * FROM students WHERE email = ?", [email]);
    if (existing.length > 0)
      return res.status(400).json({ error: "Email already registered" });

    const hashedPassword = await bcrypt.hash(password, 10);

    await pool.query(
      "INSERT INTO students (name, email, password) VALUES (?, ?, ?)",
      [name, email, hashedPassword]
    );

    res.json({ message: "✅ Student registered successfully" });
  } catch (err) {
    console.error("Error registering student:", err);
    res.status(500).json({ error: "Internal server error" });
  }
};

// ------------------------
// Student Login
// ------------------------
export const loginStudent = async (req, res) => {
  try {
    const { email, password } = req.body;
    const [rows] = await pool.query("SELECT * FROM students WHERE email = ?", [email]);

    if (rows.length === 0)
      return res.status(400).json({ error: "Invalid credentials" });

    const student = rows[0];
    const isMatch = await bcrypt.compare(password, student.password);

    if (!isMatch)
      return res.status(400).json({ error: "Invalid credentials" });

    // ✅ Save student session
    req.session.studentId = student.id;
    req.session.studentEmail = student.email;

    res.json({ message: "✅ Login successful", student });
  } catch (err) {
    console.error("Error logging in:", err);
    res.status(500).json({ error: "Internal server error" });
  }
};

// ------------------------
// Select Stream
// ------------------------
export const selectStream = async (req, res) => {
  try {
    const { stream } = req.body;

    if (!req.session.studentId)
      return res.status(401).json({ error: "Please log in first" });

    await pool.query("UPDATE students SET stream = ? WHERE id = ?", [
      stream,
      req.session.studentId,
    ]);

    res.json({ message: "✅ Stream selected successfully" });
  } catch (err) {
    console.error("Error selecting stream:", err);
    res.status(500).json({ error: "Internal server error" });
  }
};

// ------------------------
// Logout
// ------------------------
export const studentLogout = (req, res) => {
  req.session.destroy((err) => {
    if (err) return res.status(500).json({ error: "Logout failed" });
    res.clearCookie("connect.sid");
    res.json({ message: "✅ Logged out successfully" });
  });
};
