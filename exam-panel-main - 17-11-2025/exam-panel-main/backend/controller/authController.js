import bcrypt from "bcryptjs";
import { db } from "../db.js";

export const customerSignUp = async (req, res) => {
  const { name, email, mobile, address, password } = req.body;

  if (!name || !email || !password)
    return res.status(400).json({ error: "All required fields must be filled" });

  try {
    // Check if user exists
    const [existing] = await db
      .promise()
      .query("SELECT * FROM users WHERE email = ?", [email]);
    if (existing.length > 0)
      return res.status(400).json({ error: "Email already registered" });

    const hashedPassword = await bcrypt.hash(password, 10);
    await db
      .promise()
      .query(
        "INSERT INTO users (name, email, mobile, address, password, role) VALUES (?, ?, ?, ?, ?, ?)",
        [name, email, mobile, address, hashedPassword, "user"]
      );

    res.status(201).json({ message: "User registered successfully!" });
  } catch (err) {
    console.error("Signup error:", err);
    res.status(500).json({ error: "Server error during signup" });
  }
};
