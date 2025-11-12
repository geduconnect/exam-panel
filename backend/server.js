import express from "express";
import session from "express-session";
import MySQLStore from "express-mysql-session";
import cors from "cors";
import cookieParser from "cookie-parser";
import dotenv from "dotenv";
import pool from "./db.js";

// -------------------------------
// Admin Routes
// -------------------------------
import adminRoutes from "./routes/admin/adminRoutes.js";
import streamRoutes from "./routes/admin/streamRoutes.js";
import subjectRoutes from "./routes/admin/subjectRoutes.js";
import categoryRoutes from "./routes/admin/categoryRoutes.js";
import chapterRoutes from "./routes/admin/chapterRoutes.js";
import subcategoryRoutes from "./routes/admin/subcategoryRoutes.js";
import questionRoutes from "./routes/admin/questionRoutes.js";
import balancedTestsRouter from "./routes/admin/testRoutes.js";
import testsListRoutes from "./routes/admin/tests/testsList.js";
import testsViewRoutes from "./routes/admin/tests/testsView.js";
// import adminReportRoutes from "./routes/admin/adminReportRoutes.js";
// import testReportRoutes from "./routes/admin/testReport.js"; // ✅ NEW
import adminStudentRoutes from "./routes/admin/adminStudentRoutes.js";
import testSummaryRoute from "./routes/admin/tests/testSummary.js";
import testOverviewRoutes from "./routes/admin/tests/testOverview.js";
// -------------------------------
// Student Routes
// -------------------------------
import studentRoutes from "./routes/student/studentRoutes.js";
import studentReportRoutes from "./routes/student/studentReportRoutes.js";
import adminReportsRouter from "./routes/admin/reports.js";
dotenv.config();
const app = express();

// -------------------------------
// Middleware Setup
// -------------------------------
app.use(express.json());
app.use(cookieParser());
app.use(express.urlencoded({ extended: true }));

// ✅ Allow your frontend origins with credentials
const allowedOrigins = [
  "http://localhost:5173",
  "http://localhost:5174",
  "http://localhost:5175",
];

app.use(
  cors({
    origin: function (origin, callback) {
      if (!origin || allowedOrigins.includes(origin)) {
        callback(null, true);
      } else {
        callback(new Error("❌ Not allowed by CORS"));
      }
    },
    credentials: true,
  })
);

// -------------------------------
// ✅ Session Configuration (with MySQL Store)
// -------------------------------
const MySQLStoreSession = MySQLStore(session);
const sessionStore = new MySQLStoreSession({}, pool);

app.use(
  session({
    key: "connect.sid",
    secret: process.env.SESSION_SECRET || "supersecretkey",
    resave: false,
    saveUninitialized: false,
    store: sessionStore,
    cookie: {
      httpOnly: true,
      secure: false, // set to true if using HTTPS
      sameSite: "lax",
      maxAge: 1000 * 60 * 60 * 2, // 2 hours
    },
  })
);

// -------------------------------
// Test DB Connection
// -------------------------------
try {
  await pool.query("SELECT 1");
  console.log("✅ MySQL Connected Successfully");
} catch (err) {
  console.error("❌ MySQL Connection Failed:", err);
  process.exit(1);
}

// -------------------------------
// Routes
// -------------------------------

// 🔹 Admin
app.use("/admin", adminRoutes);
app.use("/admin/streams", streamRoutes);
app.use("/admin/subjects", subjectRoutes);
app.use("/admin/categories", categoryRoutes);
app.use("/admin/chapters", chapterRoutes);
app.use("/admin/subcategories", subcategoryRoutes);
app.use("/admin/questions", questionRoutes);
app.use("/admin/balanced-tests", balancedTestsRouter);
app.use("/admin/tests", testsListRoutes);
app.use("/admin/tests", testsViewRoutes);
app.use("/admin/reports", adminReportsRouter);
app.use("/admin/students", adminStudentRoutes);
app.use(testSummaryRoute);
app.use("/admin", testOverviewRoutes);

// 🔹 Student
app.use("/student", studentRoutes);
app.use("/student/reports", studentReportRoutes);

// -------------------------------
// Health Check
// -------------------------------
app.get("/", (req, res) => res.send("✅ Server is running..."));

// -------------------------------
// Start Server
// -------------------------------
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));
