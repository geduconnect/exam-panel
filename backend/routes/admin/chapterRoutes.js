import express from "express";
import { getAllChapters, createChapter, updateChapter, deleteChapter } from "../../controller/chapterController.js";
const router = express.Router();
router.get("/", getAllChapters);
router.post("/", createChapter);
router.put("/:id", updateChapter);
router.delete("/:id", deleteChapter);
export default router;
