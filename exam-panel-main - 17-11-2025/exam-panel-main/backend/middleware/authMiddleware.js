// middleware/authMiddleware.js
export const requireLogin = (req, res, next) => {
  if (!req.session.userId) {
    return res
      .status(401)
      .json({ error: "Unauthorized. Please log in first." });
  }
  next();
};

export const requireSuperAdmin = (req, res, next) => {
  if (req.session.role !== "superadmin") {
    return res.status(403).json({ error: "Access denied. Super Admin only." });
  }
  next();
};
export const requireStudent = (req, res, next) => {
  if (!req.session.studentId)
    return res.status(401).json({ error: "Unauthorized" });
  next();
};
export const studentAuth = async (req, res, next) => {
  try {
    const token = req.cookies.studentToken; // MUST MATCH COOKIE NAME

    if (!token) return res.status(401).json({ error: "Not logged in" });

    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    const [rows] = await pool.query("SELECT * FROM students WHERE id = ?", [
      decoded.id,
    ]);

    if (!rows.length) return res.status(401).json({ error: "Invalid token" });

    req.student = rows[0]; // IMPORTANT
    next();
  } catch (err) {
    console.error("StudentAuth Error:", err);
    res.status(500).json({ error: "Auth failed" });
  }
};
