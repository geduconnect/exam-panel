import express from "express";
import pool from "../../db.js";
import bcrypt from "bcrypt";

const router = express.Router();

// Fisher-Yates shuffle
function shuffleArray(arr) {
  const a = [...arr];
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

// ----------------------
// Student Registration
// ----------------------
router.post("/register", async (req, res) => {
  const { name, email, password, mobile, city, stream_id, school, section } =
    req.body;
  if (
    !name ||
    !email ||
    !password ||
    !mobile ||
    !city ||
    !school ||
    !section ||
    !stream_id
  )
    return res.status(400).json({ error: "All fields are required" });

  try {
    const [existing] = await pool.query(
      "SELECT id FROM students WHERE email=?",
      [email]
    );
    if (existing.length)
      return res.status(400).json({ error: "Email already registered" });

    const hashed = await bcrypt.hash(password, 10);
    await pool.query(
      `INSERT INTO students 
   (name, email, password, mobile, city, school, section, stream_id)
   VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
      [name, email, hashed, mobile, city, school, section, stream_id]
    );
    res.json({ message: "Registration successful! Please log in." });
  } catch (err) {
    console.error("❌ Register error:", err);
    res.status(500).json({ error: "Server error" });
  }
});

// ----------------------
// Student Login
// ----------------------
router.post("/login", async (req, res) => {
  const { email, password } = req.body;
  try {
    const [rows] = await pool.query("SELECT * FROM students WHERE email=?", [
      email,
    ]);
    if (!rows.length)
      return res.status(401).json({ error: "Invalid email or password" });

    const student = rows[0];
    const match = await bcrypt.compare(password, student.password);
    if (!match)
      return res.status(401).json({ error: "Invalid email or password" });

    req.session.studentId = student.id;
    res.json({
      student: {
        id: student.id,
        name: student.name,
        email: student.email,
        stream_id: student.stream_id,
      },
    });
  } catch (err) {
    console.error("❌ Login error:", err);
    res.status(500).json({ error: "Server error" });
  }
});
router.put("/update", async (req, res) => {
  try {
    if (!req.session.studentId) {
      return res.status(401).json({ error: "Unauthorized" });
    }

    const studentId = req.session.studentId;

    const { name, email, mobile, city, stream_id, school, section } = req.body;

    const q = `
      UPDATE students 
      SET name=?, email=?, mobile=?, city=?, stream_id=?, school=?, section=? 
      WHERE id=?
    `;

    await pool.query(q, [
      name,
      email,
      mobile,
      city,
      stream_id,
      school,
      section,
      studentId,
    ]);

    res.json({ success: true, message: "Profile updated successfully" });
  } catch (err) {
    console.error("❌ Update error:", err);
    res.status(500).json({ error: "Server error while updating profile" });
  }
});

// ✅ Get all streams
router.get("/streams", async (req, res) => {
  try {
    const [rows] = await pool.query("SELECT id, name FROM streams");
    res.json({ streams: rows });
  } catch (err) {
    console.error("❌ Error fetching streams:", err);
    res.status(500).json({ message: "Database error" });
  }
});

// ✅ Get subjects by stream
router.get("/subjects", async (req, res) => {
  const { stream_id } = req.query;
  try {
    const [rows] = await pool.query(
      "SELECT id, name FROM subjects WHERE stream_id = ?",
      [stream_id]
    );
    res.json({ subjects: rows });
  } catch (err) {
    console.error("❌ Error fetching subjects:", err);
    res.status(500).json({ message: "Database error" });
  }
});
// ----------------------
// Get Logged Student
// ----------------------
router.get("/me", async (req, res) => {
  try {
    if (!req.session || !req.session.studentId) {
      return res.status(401).json({ error: "Not authenticated" });
    }

    const studentId = req.session.studentId;

    const [rows] = await pool.query(
      `SELECT id, name, email, mobile, city, stream_id, school, section 
       FROM students WHERE id = ?`,
      [studentId]
    );

    if (rows.length === 0) {
      return res.status(404).json({ error: "Student not found" });
    }

    res.json({ student: rows[0] });
  } catch (error) {
    console.error("Error in /student/me:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});




// ----------------------
// Assigned Tests
// ----------------------
// ----------------------
// Assigned Tests (subject-wise support)
// ----------------------
router.get("/tests/assigned", async (req, res) => {
  if (!req.session.studentId)
    return res.status(401).json({ error: "Unauthorized" });

  try {
    const [[student]] = await pool.query(
      "SELECT stream_id FROM students WHERE id=?",
      [req.session.studentId]
    );

    const [tests] = await pool.query(
      `SELECT 
         t.id, 
         t.name, 
         t.total_questions, 
         t.randomize, 
         t.created_at, 
         s.name AS stream_name,
         subj.name AS subject_name
       FROM tests t
       JOIN test_assignments ta ON ta.test_id = t.id
       LEFT JOIN streams s ON t.stream_id = s.id
       LEFT JOIN subjects subj ON t.subject_id = subj.id
       WHERE (ta.assigned_to = 'stream' AND ta.assigned_id = ?)
          OR (ta.assigned_to = 'student' AND ta.assigned_id = ?)
       ORDER BY subj.name, t.created_at DESC`,
      [student?.stream_id, req.session.studentId]
    );

    res.json({ tests });
  } catch (err) {
    console.error("❌ Fetch assigned tests:", err);
    res.status(500).json({ error: "Failed to fetch tests" });
  }
});

// ----------------------
// ✅ Get subjects inside the test (subject-wise display for student)
// ----------------------
router.get("/tests/subjects/:stream_id", async (req, res) => {
  if (!req.session.studentId)
    return res.status(401).json({ error: "Unauthorized" });
  const { stream_id } = req.params;

  try {
    // 1️⃣ Find the test assigned to this stream
    const [[test]] = await pool.query(
      "SELECT id, name FROM tests WHERE stream_id = ? LIMIT 1",
      [stream_id]
    );
    if (!test)
      return res.status(404).json({ error: "No test found for this stream" });

    // 2️⃣ Get all subjects used in this test (based on test_questions)
    const [subjects] = await pool.query(
      `SELECT DISTINCT s.id, s.name
       FROM test_questions tq
       JOIN questions q ON tq.question_id = q.id
       JOIN subjects s ON q.subject_id = s.id
       WHERE tq.test_id = ?`,
      [test.id]
    );

    res.json({
      test_id: test.id,
      test_name: test.name,
      subjects,
    });
  } catch (err) {
    console.error("❌ Fetch test subjects error:", err);
    res.status(500).json({ error: "Failed to fetch subjects for test" });
  }
});

// ----------------------
// Fetch Test Questions (subject-wise + shuffle + resume support)
// ----------------------
router.get("/tests/:testId/questions", async (req, res) => {
  if (!req.session.studentId)
    return res.status(401).json({ error: "Unauthorized" });

  const { testId } = req.params;
  const { subject_id } = req.query; // 👈 New optional parameter

  try {
    // ✅ Load saved answers
    const [saved] = await pool.query(
      "SELECT question_id, answer FROM student_answers WHERE student_id=? AND test_id=?",
      [req.session.studentId, testId]
    );
    const savedMap = Object.fromEntries(
      saved.map((r) => [r.question_id, r.answer])
    );

    // ✅ Load question order if exists
    const [orderRow] = await pool.query(
      "SELECT question_order FROM test_attempts WHERE student_id=? AND test_id=?",
      [req.session.studentId, testId]
    );

    let questions = [];
    let ids = [];

    if (orderRow.length > 0 && orderRow[0].question_order) {
      try {
        ids = JSON.parse(orderRow[0].question_order);
      } catch {
        ids = [];
      }

      if (ids.length > 0) {
        const [rows] = await pool.query(
          `SELECT q.id AS question_id, q.question, q.option_a, q.option_b, q.option_c, q.option_d, q.level, q.subject_id
           FROM questions q
           WHERE q.id IN (?) ${subject_id ? "AND q.subject_id=?" : ""}`,
          subject_id ? [ids, subject_id] : [ids]
        );
        const map = Object.fromEntries(rows.map((q) => [q.question_id, q]));
        questions = ids.map((id) => map[id]).filter(Boolean);
      }
    }

    // ✅ If no saved order found (first attempt)
    if (questions.length === 0) {
      const [rows] = await pool.query(
        `SELECT q.id AS question_id, q.question, q.option_a, q.option_b, q.option_c, q.option_d, q.level, q.subject_id
         FROM test_questions tq 
         JOIN questions q ON tq.question_id=q.id
         WHERE tq.test_id=? ${subject_id ? "AND q.subject_id=?" : ""}`,
        subject_id ? [testId, subject_id] : [testId]
      );
      const shuffled = shuffleArray(rows);
      const order = shuffled.map((q) => q.question_id);

      await pool.query(
        "INSERT INTO test_attempts (student_id,test_id,question_order,started_at) VALUES (?,?,?,NOW()) ON DUPLICATE KEY UPDATE question_order=VALUES(question_order)",
        [req.session.studentId, testId, JSON.stringify(order)]
      );
      questions = shuffled;
    }

    res.json({ questions, savedAnswers: savedMap });
  } catch (err) {
    console.error("❌ Fetch questions error:", err);
    res.status(500).json({ error: "Failed to fetch test questions" });
  }
});

// ----------------------
// Auto-Save Answers
// ----------------------
router.post("/tests/:testId/save", async (req, res) => {
  if (!req.session.studentId)
    return res.status(401).json({ error: "Unauthorized" });

  const { testId } = req.params;
  const { answers } = req.body;

  try {
    for (const [questionId, answer] of Object.entries(answers)) {
      await pool.query(
        `INSERT INTO student_answers (student_id, test_id, question_id, answer)
         VALUES (?, ?, ?, ?)
         ON DUPLICATE KEY UPDATE answer=VALUES(answer)`,
        [req.session.studentId, testId, questionId, answer]
      );
    }

    res.json({ message: "Progress saved" });
  } catch (err) {
    console.error("❌ Error saving answers:", err);
    res.status(500).json({ error: "Failed to save answers" });
  }
});

// ----------------------
// Submit Test (from saved answers)
// ----------------------
router.post("/tests/:testId/submit", async (req, res) => {
  if (!req.session.studentId)
    return res.status(401).json({ error: "Unauthorized" });
  const { testId } = req.params;
  try {
    const [answers] = await pool.query(
      `SELECT q.id,q.correct_answer,sa.answer 
       FROM student_answers sa JOIN questions q ON sa.question_id=q.id
       WHERE sa.student_id=? AND sa.test_id=?`,
      [req.session.studentId, testId]
    );

    if (!answers.length)
      return res.status(400).json({ error: "No answers found to submit." });

    const total = answers.length;
    const correct = answers.filter(
      (a) =>
        a.answer &&
        a.correct_answer?.trim().toLowerCase() ===
          a.answer?.trim().toLowerCase()
    ).length;

    const percentage = ((correct / total) * 100).toFixed(2);

    await pool.query(
      `INSERT INTO test_results (student_id,test_id,score,total_questions,percentage,submitted_at)
       VALUES (?,?,?,?,?,NOW())
       ON DUPLICATE KEY UPDATE score=VALUES(score), total_questions=VALUES(total_questions), percentage=VALUES(percentage), submitted_at=NOW()`,
      [req.session.studentId, testId, correct, total, percentage]
    );

    res.json({ success: true, correct, total, percentage });
  } catch (err) {
    console.error("❌ Submit error:", err);
    res.status(500).json({ error: "Failed to submit test" });
  }
});
// ----------------------
// Fetch all test results for the logged-in student
// ----------------------
// ✅ Fetch all test results for the logged-in student
router.get("/results", async (req, res) => {
  if (!req.session.studentId)
    return res.status(401).json({ error: "Unauthorized" });

  try {
    const [results] = await pool.query(
      `SELECT 
         tr.test_id,
         t.name AS test_name,
         tr.score,
         tr.total_questions,
         tr.percentage,
         tr.submitted_at AS created_at
       FROM test_results tr
       JOIN tests t ON tr.test_id = t.id
       WHERE tr.student_id = ?
       ORDER BY tr.submitted_at DESC`,
      [req.session.studentId]
    );

    res.json({ results });
  } catch (err) {
    console.error("❌ Fetch student results error:", err);
    res.status(500).json({ error: "Failed to load reports." });
  }
});

// ✅ Detailed test report (now includes subject-wise performance)
router.get("/test-report", async (req, res) => {
  if (!req.session.studentId)
    return res.status(401).json({ error: "Unauthorized" });

  const { test_id } = req.query;
  if (!test_id) return res.status(400).json({ error: "Missing test_id" });

  try {
    // 🟩 Test Overview
    const [[overview]] = await pool.query(
      `SELECT 
         t.name AS test_name,
         tr.score,
         tr.total_questions,
         tr.percentage,
         tr.submitted_at AS date
       FROM test_results tr
       JOIN tests t ON t.id = tr.test_id
       WHERE tr.student_id = ? AND tr.test_id = ?`,
      [req.session.studentId, test_id]
    );

    if (!overview) return res.status(404).json({ error: "No report found." });

    // 🟩 Subject-wise performance
    const [subjectwise] = await pool.query(
      `SELECT 
         s.name AS subject_name,
         COUNT(q.id) AS total_questions,
         SUM(
           CASE 
             WHEN sa.answer IS NOT NULL 
              AND LOWER(TRIM(sa.answer)) = LOWER(TRIM(q.correct_answer)) 
             THEN 1 ELSE 0 END
         ) AS correct_answers,
         ROUND(
           SUM(
             CASE 
               WHEN sa.answer IS NOT NULL 
                AND LOWER(TRIM(sa.answer)) = LOWER(TRIM(q.correct_answer)) 
               THEN 1 ELSE 0 END
           ) / COUNT(q.id) * 100, 2
         ) AS accuracy
       FROM student_answers sa
       JOIN questions q ON q.id = sa.question_id
       LEFT JOIN subjects s ON q.subject_id = s.id
       WHERE sa.student_id = ? AND sa.test_id = ?
       GROUP BY s.id, s.name
       ORDER BY s.name`,
      [req.session.studentId, test_id]
    );

    // 🟩 Chapter-wise performance
    const [chapterwise] = await pool.query(
      `SELECT 
         s.name AS subject_name,
         c.name AS chapter_name,
         COUNT(q.id) AS total,
         SUM(
           CASE 
             WHEN sa.answer IS NOT NULL 
              AND LOWER(TRIM(sa.answer)) = LOWER(TRIM(q.correct_answer)) 
             THEN 1 ELSE 0 END
         ) AS correct,
         ROUND(
           SUM(
             CASE 
               WHEN sa.answer IS NOT NULL 
                AND LOWER(TRIM(sa.answer)) = LOWER(TRIM(q.correct_answer)) 
               THEN 1 ELSE 0 END
           ) / COUNT(q.id) * 100, 2
         ) AS accuracy
       FROM student_answers sa
       JOIN questions q ON q.id = sa.question_id
       LEFT JOIN subjects s ON q.subject_id = s.id
       LEFT JOIN chapters c ON q.chapter_id = c.id
       WHERE sa.student_id = ? AND sa.test_id = ?
       GROUP BY s.id, c.id
       ORDER BY s.name, c.name`,
      [req.session.studentId, test_id]
    );

    res.json({ overview, subjectwise, chapterwise });
  } catch (err) {
    console.error("❌ Fetch single test report error:", err);
    res.status(500).json({ error: "Failed to load detailed report." });
  }
});

// ----------------------
// Logout
// ----------------------
router.post("/logout", (req, res) => {
  req.session.destroy(() => {
    res.clearCookie("connect.sid");
    res.json({ message: "Logged out" });
  });
});

export default router;
