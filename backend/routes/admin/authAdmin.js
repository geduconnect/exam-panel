import express from "express";
import bcrypt from "bcrypt";
import pool from "../../db.js";

const router = express.Router();

// Super Admin Login
router.post("/login", async (req, res) => {
  const { email, password } = req.body;

  try {
    const [rows] = await pool.query("SELECT * FROM admin_users WHERE email = ?", [email]);
    if (rows.length === 0) return res.status(400).json({ error: "User not found" });

    const admin = rows[0];
    const valid = await bcrypt.compare(password, admin.password);
    if (!valid) return res.status(400).json({ error: "Invalid password" });

    req.session.adminId = admin.id;
    req.session.role = admin.role;

    res.json({ message: "Login successful", role: admin.role });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
});

// Logout
router.post("/logout", (req, res) => {
  req.session.destroy(() => {
    res.clearCookie("connect.sid");
    res.json({ message: "Logout successful" });
  });
});

export default router;
