import express from "express";
import { getAllSubcategories, createSubcategory, updateSubcategory, deleteSubcategory } from "../../controller/subcategoryController.js";
const router = express.Router();
router.get("/", getAllSubcategories);
router.post("/", createSubcategory);
router.put("/:id", updateSubcategory);
router.delete("/:id", deleteSubcategory);
export default router;
