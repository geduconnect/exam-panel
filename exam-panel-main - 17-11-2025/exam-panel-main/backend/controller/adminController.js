// controllers/admin/adminController.js
import bcrypt from "bcrypt";
import pool from "../db.js";

// ----------------------
// Admin Login Controller
// ----------------------
export const adminLogin = async (req, res) => {
  const { email, password } = req.body;

  try {
    const [rows] = await pool.query(
      "SELECT * FROM admin_users WHERE email = ?",
      [email]
    );

    if (rows.length === 0) {
      return res.status(404).json({ error: "User not found" });
    }

    const admin = rows[0];

    const isMatch = await bcrypt.compare(password, admin.password);
    if (!isMatch) {
      return res.status(401).json({ error: "Invalid credentials" });
    }

    // Create session
 req.session.userId = admin.id;
req.session.role = admin.role;

req.session.save(() => {
  res.json({
    message: "Login successful",
    user: {
      id: admin.id,
      name: admin.name,
      email: admin.email,
      role: admin.role,
    },
  });
});

  } catch (error) {
    console.error("Login Error:", error);
    res.status(500).json({ error: "Server error during login" });
  }
};

// ----------------------
// Add New Admin User (Super Admin Only)
// ----------------------
export const addAdminUser = async (req, res) => {
  const { name, email, password, role } = req.body;

  // Allow only Super Admin
  if (req.session.role !== "superadmin") {
    return res.status(403).json({ error: "Access denied. Super Admin only." });
  }

  try {
    const [existing] = await pool.query(
      "SELECT * FROM admin_users WHERE email = ?",
      [email]
    );
    if (existing.length > 0) {
      return res.status(400).json({ error: "User already exists" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    await pool.query(
      "INSERT INTO admin_users (name, email, password, role) VALUES (?, ?, ?, ?)",
      [name, email, hashedPassword, role || "admin"]
    );

    res.json({ message: "Admin user created successfully" });
  } catch (error) {
    console.error("Add User Error:", error);
    res.status(500).json({ error: "Server error while creating user" });
  }
};

// ----------------------
// Get All Admin Users (Super Admin Only)
// ----------------------
export const getAllAdminUsers = async (req, res) => {
  if (req.session.role !== "superadmin") {
    return res.status(403).json({ error: "Access denied. Super Admin only." });
  }

  try {
    const [rows] = await pool.query(
      "SELECT id, name, email, role, created_at FROM admin_users"
    );
    res.json(rows);
  } catch (error) {
    console.error("Fetch Users Error:", error);
    res.status(500).json({ error: "Server error fetching users" });
  }
};

// ----------------------
// Logout Controller
// ----------------------
export const adminLogout = (req, res) => {
  req.session.destroy(() => {
    res.clearCookie("connect.sid");
    res.json({ message: "Logout successful" });
  });
};
