// seed.js
import bcrypt from "bcrypt";
import pool from "./db.js";

const seedSuperAdmin = async () => {
  try {
    const name = "Super Admin";
    const email = "super@admin.com";
    const password = "SuperAdmin123";
    const role = "superadmin";

    // check if superadmin already exists
    const [rows] = await pool.query("SELECT * FROM admin_users WHERE role = ?", [role]);
    if (rows.length > 0) {
      console.log("⚠️ Super Admin already exists!");
      process.exit(0);
    }

    // hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // insert super admin
    await pool.query(
      "INSERT INTO admin_users (name, email, password, role) VALUES (?, ?, ?, ?)",
      [name, email, hashedPassword, role]
    );

    console.log("✅ Super Admin created successfully!");
    console.log(`➡️  Email: ${email}`);
    console.log(`➡️  Password: ${password}`);
    process.exit(0);
  } catch (error) {
    console.error("❌ Error seeding Super Admin:", error);
    process.exit(1);
  }
};

seedSuperAdmin();
