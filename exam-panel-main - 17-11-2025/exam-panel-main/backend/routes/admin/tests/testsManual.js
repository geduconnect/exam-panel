// routes/admin/testsManual.js
import express from "express";
import pool from "../../../db.js";

const router = express.Router();

/**
 * POST /admin/tests/create-manual
 * Body:
 * {
 *   name: "Mid Term Test",
 *   stream_id: 1,
 *   set_name: "A",
 *   total_duration: 90,
 *   question_ids: [1,2,3,4,...]
 * }
 */
router.post("/create-manual", async (req, res) => {
  const {
    name,
    stream_id,
    set_name = "A",
    total_duration = 90,
    question_ids = [],
  } = req.body;

  if (
    !name ||
    !stream_id ||
    !Array.isArray(question_ids) ||
    question_ids.length === 0
  ) {
    return res.status(400).json({
      success: false,
      message:
        "Missing required fields: name, stream_id, question_ids (non-empty array)",
    });
  }

  const connection = await pool.getConnection();
  try {
    await connection.beginTransaction();

    // 1️⃣ Create Test
    const [testResult] = await connection.query(
      `INSERT INTO tests (name, stream_id, total_duration) VALUES (?, ?, ?)`,
      [name, stream_id, total_duration]
    );
    const testId = testResult.insertId;

    // 2️⃣ Create Test Set
    const [setResult] = await connection.query(
      `INSERT INTO test_sets (test_id, set_name) VALUES (?, ?)`,
      [testId, set_name]
    );
    const testSetId = setResult.insertId;

    const uniqueIds = Array.from(
      new Set(question_ids.map((id) => Number(id)).filter(Boolean))
    );
    if (uniqueIds.length === 0)
      throw new Error("No valid question IDs provided");

    const [rows] = await connection.query(
      `SELECT id, subject_id, chapter_id, IFNULL(level, 'medium') AS level
   FROM questions WHERE id IN (?)`,
      [uniqueIds]
    );

    // 4) Validate: every requested id must exist
    const foundIds = rows.map((r) => r.id);
    const missing = uniqueIds.filter((id) => !foundIds.includes(id));
    if (missing.length > 0) {
      throw new Error(
        `Some question IDs were not found: ${missing.join(", ")}`
      );
    }

    // 5) Insert into test_set_questions
    const values = rows.map((r) => [
      testSetId,
      r.subject_id || null,
      r.id,
      r.level || "medium",
      r.chapter_id || null,
    ]);

    if (values.length > 0) {
      await connection.query(
        `INSERT INTO test_set_questions (test_set_id, subject_id, question_id, difficulty, chapter_id) VALUES ?`,
        [values]
      );
    }

    await connection.commit();

    return res.status(201).json({
      success: true,
      message: `✅ Test and set created successfully. ${values.length} questions added to Set ${set_name}.`,
      data: { testId, testSetId, insertedQuestions: values.length },
    });
  } catch (err) {
    await connection.rollback();
    console.error("create-manual error:", err);
    return res
      .status(500)
      .json({ success: false, message: err.message || "Server error" });
  } finally {
    connection.release();
  }
});

export default router;
