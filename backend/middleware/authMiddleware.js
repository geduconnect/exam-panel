// middleware/authMiddleware.js
export const requireLogin = (req, res, next) => {
  if (!req.session.userId) {
    return res.status(401).json({ error: "Unauthorized. Please log in first." });
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
  if (!req.session.studentId) return res.status(401).json({ error: "Unauthorized" });
  next();
};