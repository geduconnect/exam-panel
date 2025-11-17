import axios from "axios";
import fs from "fs";
import path from "path";
import XLSX from "xlsx";
import pool from "../db.js";
import multer from "multer";

const upload = multer({ dest: "uploads/" });

// ------------------------
// GET all questions (with filters)
// ------------------------
export const getAllQuestions = async (req, res) => {
  try {
    const { stream_id, subject_id, category_id, chapter_id, subcategory_id, level } = req.query;

    let sql = `
      SELECT q.*, 
        s.name AS stream_name,
        sub.name AS subject_name,
        c.name AS category_name,
        ch.name AS chapter_name,
        sc.name AS subcategory_name
      FROM questions q
      LEFT JOIN streams s ON q.stream_id = s.id
      LEFT JOIN subjects sub ON q.subject_id = sub.id
      LEFT JOIN categories c ON q.category_id = c.id
      LEFT JOIN chapters ch ON q.chapter_id = ch.id
      LEFT JOIN subcategories sc ON q.subcategory_id = sc.id
      WHERE 1=1
    `;
    const params = [];

    if (stream_id) { sql += " AND q.stream_id = ?"; params.push(stream_id); }
    if (subject_id) { sql += " AND q.subject_id = ?"; params.push(subject_id); }
    if (category_id) { sql += " AND q.category_id = ?"; params.push(category_id); }
    if (chapter_id) { sql += " AND q.chapter_id = ?"; params.push(chapter_id); }
    if (subcategory_id) { sql += " AND q.subcategory_id = ?"; params.push(subcategory_id); }
    if (level) { sql += " AND q.level = ?"; params.push(level); }

    sql += " ORDER BY q.id DESC";

    const [rows] = await pool.query(sql, params);
    res.json(rows);
  } catch (err) {
    console.error("❌ Error fetching questions:", err);
    res.status(500).json({ error: "Failed to fetch questions" });
  }
};

// ------------------------
// ADD new question
// ------------------------
export const addQuestion = async (req, res) => {
  try {
    const {
      question, option_a, option_b, option_c, option_d,
      correct_answer, level, explanation,
      stream_id, subject_id, category_id, chapter_id, subcategory_id
    } = req.body;

    if (!question || !correct_answer || !stream_id || !subject_id)
      return res.status(400).json({ error: "Missing required fields" });

    await pool.query(
      `INSERT INTO questions 
      (question, option_a, option_b, option_c, option_d, correct_answer, level, explanation,
       stream_id, subject_id, category_id, chapter_id, subcategory_id)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        question, option_a, option_b, option_c, option_d,
        correct_answer, level, explanation,
        stream_id, subject_id, category_id, chapter_id, subcategory_id
      ]
    );

    res.status(201).json({ message: "✅ Question added successfully" });
  } catch (err) {
    console.error("❌ Error adding question:", err);
    res.status(500).json({ error: "Failed to add question" });
  }
};

// ------------------------
// UPDATE question
// ------------------------
export const updateQuestion = async (req, res) => {
  try {
    const { id } = req.params;
    const {
      question, option_a, option_b, option_c, option_d,
      correct_answer, level, explanation,
      stream_id, subject_id, category_id, chapter_id, subcategory_id
    } = req.body;

    await pool.query(
      `UPDATE questions 
       SET question=?, option_a=?, option_b=?, option_c=?, option_d=?, correct_answer=?, level=?, explanation=?, 
           stream_id=?, subject_id=?, category_id=?, chapter_id=?, subcategory_id=?
       WHERE id=?`,
      [
        question, option_a, option_b, option_c, option_d,
        correct_answer, level, explanation,
        stream_id, subject_id, category_id, chapter_id, subcategory_id, id
      ]
    );

    res.json({ message: "✅ Question updated successfully" });
  } catch (err) {
    console.error("❌ Error updating question:", err);
    res.status(500).json({ error: "Failed to update question" });
  }
};

// ------------------------
// DELETE question
// ------------------------
export const deleteQuestion = async (req, res) => {
  try {
    const { id } = req.params;
    await pool.query("DELETE FROM questions WHERE id = ?", [id]);
    res.json({ message: "✅ Question deleted successfully" });
  } catch (err) {
    console.error("❌ Error deleting question:", err);
    res.status(500).json({ error: "Failed to delete question" });
  }
};

// ------------------------
// BULK delete
// ------------------------
export const bulkDeleteQuestions = async (req, res) => {
  try {
    const { ids } = req.body;
    if (!Array.isArray(ids) || ids.length === 0)
      return res.status(400).json({ error: "No questions selected" });

    const placeholders = ids.map(() => "?").join(",");
    await pool.query(`DELETE FROM questions WHERE id IN (${placeholders})`, ids);

    res.json({ message: "✅ Selected questions deleted successfully" });
  } catch (err) {
    console.error("❌ Error bulk deleting questions:", err);
    res.status(500).json({ error: "Failed to delete selected questions" });
  }
};

// 🔹 Download image from URL
async function downloadImage(url, folder = "uploads/questions") {
  try {
    if (!url || !url.startsWith("http")) return null;

    if (!fs.existsSync(folder)) fs.mkdirSync(folder, { recursive: true });

    const filename = `${Date.now()}_${path.basename(url).split("?")[0]}`;
    const filepath = path.join(folder, filename);

    const response = await axios({
      url,
      method: "GET",
      responseType: "stream",
      timeout: 15000,
    });

    await new Promise((resolve, reject) => {
      const writer = fs.createWriteStream(filepath);
      response.data.pipe(writer);
      writer.on("finish", resolve);
      writer.on("error", reject);
    });

    return `/uploads/questions/${filename}`;
  } catch (err) {
    console.error("❌ Failed to download image:", url, err.message);
    return null;
  }
}

// 🔹 Copy local image if path exists
function copyLocalImage(localPath, folder = "uploads/questions") {
  try {
    if (!localPath) return null;
    if (!fs.existsSync(folder)) fs.mkdirSync(folder, { recursive: true });

    // normalize paths
    const src = path.resolve("uploads/import_images", localPath);
    if (!fs.existsSync(src)) {
      console.warn("⚠️ Image not found:", src);
      return null;
    }

    const filename = `${Date.now()}_${path.basename(src)}`;
    const dest = path.join(folder, filename);
    fs.copyFileSync(src, dest);

    return `/uploads/questions/${filename}`;
  } catch (err) {
    console.error("❌ Failed to copy local image:", localPath, err.message);
    return null;
  }
}

// 🔹 Controller
export const importQuestions = [
  upload.single("file"),
  async (req, res) => {
    try {
      console.log("📂 File received:", req.file);
    
      const { stream_id, subject_id, category_id, chapter_id, subcategory_id } = req.body;
      if (!req.file) return res.status(400).json({ error: "No file uploaded" });

      const workbook = XLSX.readFile(req.file.path);
      const sheetName = workbook.SheetNames[0];
      const data = XLSX.utils.sheet_to_json(workbook.Sheets[sheetName]);

      if (!Array.isArray(data) || data.length === 0)
        return res.status(400).json({ error: "No questions found in Excel" });

      const insertValues = [];

      for (const q of data) {
        const question = q.question || q.Question || "";
        if (!question) continue;

        const option_a = q.option_a || q["Option A"] || "";
        const option_b = q.option_b || q["Option B"] || "";
        const option_c = q.option_c || q["Option C"] || "";
        const option_d = q.option_d || q["Option D"] || "";
        const correct_answer = q.correct_answer || q["Correct Answer"] || "";
        const explanation = q.explanation || q.Explanation || "";
        const level = q.level || q.Level || "medium";

        // Get image paths
        const qImg = q["Question Image"] || null;
        const optAImg = q["Option A Image"] || null;
        const optBImg = q["Option B Image"] || null;
        const optCImg = q["Option C Image"] || null;
        const optDImg = q["Option D Image"] || null;

        // Decide: download (URL) or copy (local)
        const question_image = qImg
          ? qImg.startsWith("http")
            ? await downloadImage(qImg)
            : copyLocalImage(qImg)
          : null;

        const option_a_image = optAImg
          ? optAImg.startsWith("http")
            ? await downloadImage(optAImg)
            : copyLocalImage(optAImg)
          : null;

        const option_b_image = optBImg
          ? optBImg.startsWith("http")
            ? await downloadImage(optBImg)
            : copyLocalImage(optBImg)
          : null;

        const option_c_image = optCImg
          ? optCImg.startsWith("http")
            ? await downloadImage(optCImg)
            : copyLocalImage(optCImg)
          : null;

        const option_d_image = optDImg
          ? optDImg.startsWith("http")
            ? await downloadImage(optDImg)
            : copyLocalImage(optDImg)
          : null;

        insertValues.push([
          question,
          option_a,
          option_b,
          option_c,
          option_d,
          correct_answer,
          explanation,
          level,
          question_image,
          option_a_image,
          option_b_image,
          option_c_image,
          option_d_image,
          stream_id || null,
          subject_id || null,
          category_id || null,
          chapter_id || null,
          subcategory_id || null,
        ]);
      }

      if (insertValues.length === 0)
        return res.status(400).json({ error: "No valid questions found" });

      const sql = `
        INSERT INTO questions (
          question, option_a, option_b, option_c, option_d,
          correct_answer, explanation, level,
          question_image, option_a_image, option_b_image, option_c_image, option_d_image,
          stream_id, subject_id, category_id, chapter_id, subcategory_id
        ) VALUES ?
      `;

      await pool.query(sql, [insertValues]);

      fs.unlinkSync(req.file.path);

      res.json({ message: `${insertValues.length} questions imported successfully!` });
    } catch (err) {
      console.error("❌ Error importing questions:", err);
      res.status(500).json({ error: "Failed to import questions" });
    }
  },
];

// ------------------------
// EXPORT to Excel
// ------------------------
export const exportQuestions = async (req, res) => {
  try {
    const [rows] = await pool.query(`
      SELECT q.*, s.name AS stream, sub.name AS subject, c.name AS category,
             ch.name AS chapter, sc.name AS subcategory
      FROM questions q
      LEFT JOIN streams s ON q.stream_id = s.id
      LEFT JOIN subjects sub ON q.subject_id = sub.id
      LEFT JOIN categories c ON q.category_id = c.id
      LEFT JOIN chapters ch ON q.chapter_id = ch.id
      LEFT JOIN subcategories sc ON q.subcategory_id = sc.id
    `);

    const worksheet = XLSX.utils.json_to_sheet(rows);
    const workbook = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(workbook, worksheet, "Questions");

    const filePath = path.join("exports", `questions_${Date.now()}.xlsx`);
    XLSX.writeFile(workbook, filePath);
    res.download(filePath, () => fs.unlinkSync(filePath));
  } catch (err) {
    console.error("❌ Error exporting questions:", err);
    res.status(500).json({ error: "Failed to export questions" });
  }
};
