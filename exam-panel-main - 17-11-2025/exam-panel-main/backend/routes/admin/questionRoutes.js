import express from "express";
import multer from "multer";
import {
  getAllQuestions,
  addQuestion,
  updateQuestion,
  deleteQuestion,
  importQuestions,
  bulkDeleteQuestions,
  exportQuestions,
} from "../../controller/questionController.js";



const router = express.Router();
const upload = multer({ dest: "uploads/" }); // ✅ temp folder

// Routes
router.get("/", getAllQuestions); // Get all questions (with filters)
router.post("/", addQuestion); // Add new question
router.put("/:id", updateQuestion); // Update question
router.delete("/:id", deleteQuestion); // Delete one question
router.post("/bulk-delete", bulkDeleteQuestions); // 🗑️ Bulk delete

router.get("/export", exportQuestions); // 📤 Export all questions
router.post("/import-questions", importQuestions);

export default router;
