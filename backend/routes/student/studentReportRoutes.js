import express from "express";
import db from "../../db.js";
import ExcelJS from "exceljs";
import { jsPDF } from "jspdf";
import autoTable from "jspdf-autotable";

const router = express.Router();

/**
 * 🔹 Student: Get detailed report
 */
router.get("/my-report", async (req, res) => {
  const { student_id, test_id } = req.query;
  if (!student_id || !test_id)
    return res.status(400).json({ error: "Student ID and Test ID are required" });

  try {
    const [overview] = await db.query(
      `SELECT 
         t.name AS test_name,
         s.name AS student_name,
         r.total_questions,
         r.correct,
         r.wrong,
         r.percentage,
         r.performance,
         r.total_marks
       FROM test_results r
       JOIN students s ON r.student_id = s.id
       JOIN tests t ON r.test_id = t.id
       WHERE r.student_id = ? AND r.test_id = ?`,
      [student_id, test_id]
    );

    const [chapters] = await db.query(
      `SELECT 
         sub.name AS subject,
         c.name AS category,
         ch.name AS chapter,
         d.total_questions,
         d.correct,
         d.accuracy,
         d.remarks
       FROM test_result_details d
       JOIN subjects sub ON d.subject_id = sub.id
       JOIN categories c ON d.category_id = c.id
       JOIN chapters ch ON d.chapter_id = ch.id
       WHERE d.result_id = (
         SELECT id FROM test_results 
         WHERE student_id = ? AND test_id = ? LIMIT 1
       )`,
      [student_id, test_id]
    );

    res.json({ overview: overview[0], chapters });
  } catch (err) {
    console.error("❌ Error fetching student report:", err);
    res.status(500).json({ error: "Failed to load student report" });
  }
});

/**
 * 🔹 Student: Export Report (PDF / Excel)
 * GET /student/reports/export?student_id=5&test_id=2&type=pdf/excel
 */
router.get("/export", async (req, res) => {
  const { student_id, test_id, type } = req.query;
  if (!student_id || !test_id || !type)
    return res.status(400).json({ error: "student_id, test_id, and type required" });

  try {
    const [overview] = await db.query(
      `SELECT 
         t.name AS test_name,
         s.name AS student_name,
         r.total_marks,
         r.percentage,
         r.performance
       FROM test_results r
       JOIN students s ON r.student_id = s.id
       JOIN tests t ON r.test_id = t.id
       WHERE r.student_id = ? AND r.test_id = ?`,
      [student_id, test_id]
    );

    const [chapters] = await db.query(
      `SELECT 
         sub.name AS subject,
         c.name AS category,
         ch.name AS chapter,
         d.total_questions,
         d.correct,
         d.accuracy,
         d.remarks
       FROM test_result_details d
       JOIN subjects sub ON d.subject_id = sub.id
       JOIN categories c ON d.category_id = c.id
       JOIN chapters ch ON d.chapter_id = ch.id
       WHERE d.result_id = (
         SELECT id FROM test_results WHERE student_id = ? AND test_id = ? LIMIT 1
       )`,
      [student_id, test_id]
    );

    if (type === "excel") {
      const workbook = new ExcelJS.Workbook();
      const sheet = workbook.addWorksheet("Student Report");

      sheet.addRow(["Student Name", overview[0].student_name]);
      sheet.addRow(["Test Name", overview[0].test_name]);
      sheet.addRow(["Percentage", `${overview[0].percentage}%`]);
      sheet.addRow(["Performance", overview[0].performance]);
      sheet.addRow([]);

      sheet.addRow(["Subject", "Category", "Chapter", "Total Qs", "Correct", "Accuracy", "Remarks"]);
      chapters.forEach((c) =>
        sheet.addRow([c.subject, c.category, c.chapter, c.total_questions, c.correct, c.accuracy, c.remarks])
      );

      res.setHeader("Content-Type", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
      res.setHeader("Content-Disposition", `attachment; filename="student_report_${student_id}_${test_id}.xlsx"`);

      await workbook.xlsx.write(res);
      res.end();
    } else if (type === "pdf") {
      const doc = new jsPDF();
      doc.text(`Student Report - ${overview[0].student_name}`, 14, 10);
      doc.text(`Test: ${overview[0].test_name}`, 14, 18);
      doc.text(`Score: ${overview[0].percentage}% (${overview[0].performance})`, 14, 26);

      const rows = chapters.map((c) => [
        c.subject,
        c.category,
        c.chapter,
        c.total_questions,
        c.correct,
        `${c.accuracy}%`,
        c.remarks,
      ]);

      autoTable(doc, {
        startY: 36,
        head: [["Subject", "Category", "Chapter", "Total Qs", "Correct", "Accuracy", "Remarks"]],
        body: rows,
      });

      const pdf = doc.output();
      res.setHeader("Content-Type", "application/pdf");
      res.setHeader("Content-Disposition", `attachment; filename="student_report_${student_id}_${test_id}.pdf"`);
      res.send(Buffer.from(pdf, "binary"));
    }
  } catch (err) {
    console.error("❌ Error exporting student report:", err);
    res.status(500).json({ error: "Failed to export report" });
  }
});

export default router;
