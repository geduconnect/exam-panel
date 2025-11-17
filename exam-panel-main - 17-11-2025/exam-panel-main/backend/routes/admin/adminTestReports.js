import express from "express";
import db from "../../db.js";
import ExcelJS from "exceljs";
import { jsPDF } from "jspdf";
import autoTable from "jspdf-autotable";

const router = express.Router();

/**
 * 🔹 Admin: Fetch test summary
 */
router.get("/test-summary", async (req, res) => {
  const { test_id } = req.query;
  if (!test_id) return res.status(400).json({ error: "Test ID is required" });

  try {
    const [summary] = await db.query(
      `SELECT 
         t.name AS test_name,
         COUNT(r.id) AS total_attempts,
         AVG(r.percentage) AS avg_percentage,
         MAX(r.percentage) AS highest_score,
         MIN(r.percentage) AS lowest_score
       FROM test_results r
       JOIN tests t ON r.test_id = t.id
       WHERE r.test_id = ?`,
      [test_id]
    );

    const [students] = await db.query(
      `SELECT 
         s.id AS student_id,
         s.name AS student_name,
         r.total_marks,
         r.percentage,
         r.performance
       FROM test_results r
       JOIN students s ON r.student_id = s.id
       WHERE r.test_id = ?
       ORDER BY r.percentage DESC`,
      [test_id]
    );

    res.json({
      test_id,
      summary: summary[0],
      students,
    });
  } catch (err) {
    console.error("❌ Error loading admin test report:", err);
    res.status(500).json({ error: "Failed to fetch test report" });
  }
});

/**
 * 🔹 Admin: Chapter-wise analysis
 */
router.get("/test-chapters", async (req, res) => {
  const { test_id } = req.query;
  if (!test_id) return res.status(400).json({ error: "Test ID is required" });

  try {
    const [rows] = await db.query(
      `SELECT 
         sub.name AS subject,
         c.name AS category,
         ch.name AS chapter,
         AVG(d.accuracy) AS avg_accuracy
       FROM test_result_details d
       JOIN test_results r ON d.result_id = r.id
       JOIN subjects sub ON d.subject_id = sub.id
       JOIN categories c ON d.category_id = c.id
       JOIN chapters ch ON d.chapter_id = ch.id
       WHERE r.test_id = ?
       GROUP BY d.subject_id, d.category_id, d.chapter_id`,
      [test_id]
    );

    res.json({ test_id, chapter_analysis: rows });
  } catch (err) {
    console.error("❌ Error fetching chapter analysis:", err);
    res.status(500).json({ error: "Failed to fetch chapter report" });
  }
});

/**
 * 🔹 Admin: Export Report (Excel / PDF)
 * GET /admin/reports/export?test_id=1&type=excel/pdf
 */
router.get("/export", async (req, res) => {
  const { test_id, type } = req.query;
  if (!test_id || !type)
    return res.status(400).json({ error: "test_id and type are required" });

  try {
    const [students] = await db.query(
      `SELECT 
         s.name AS student_name,
         r.total_marks,
         r.percentage,
         r.performance
       FROM test_results r
       JOIN students s ON r.student_id = s.id
       WHERE r.test_id = ?
       ORDER BY r.percentage DESC`,
      [test_id]
    );

    if (!students.length) return res.status(404).json({ error: "No records found" });

    if (type === "excel") {
      const workbook = new ExcelJS.Workbook();
      const sheet = workbook.addWorksheet("Test Report");

      sheet.columns = [
        { header: "Student Name", key: "student_name", width: 25 },
        { header: "Total Marks", key: "total_marks", width: 15 },
        { header: "Percentage", key: "percentage", width: 15 },
        { header: "Performance", key: "performance", width: 20 },
      ];
      sheet.addRows(students);

      res.setHeader("Content-Type", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
      res.setHeader("Content-Disposition", `attachment; filename="test_report_${test_id}.xlsx"`);

      await workbook.xlsx.write(res);
      res.end();
    } else if (type === "pdf") {
      const doc = new jsPDF();
      doc.text(`Test Report (Test ID: ${test_id})`, 14, 10);
      const rows = students.map((s) => [s.student_name, s.total_marks, s.percentage, s.performance]);

      autoTable(doc, {
        startY: 20,
        head: [["Student Name", "Total Marks", "Percentage", "Performance"]],
        body: rows,
      });

      const pdf = doc.output();
      res.setHeader("Content-Type", "application/pdf");
      res.setHeader("Content-Disposition", `attachment; filename="test_report_${test_id}.pdf"`);
      res.send(Buffer.from(pdf, "binary"));
    } else {
      res.status(400).json({ error: "Invalid type. Use 'excel' or 'pdf'." });
    }
  } catch (err) {
    console.error("❌ Export error:", err);
    res.status(500).json({ error: "Failed to export report" });
  }
});

export default router;
