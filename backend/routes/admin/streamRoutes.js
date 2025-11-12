import express from "express";
import { getAllStreams, createStream, updateStream, deleteStream } from "../../controller/streamController.js";
const router = express.Router();
router.get("/", getAllStreams);
router.post("/", createStream);
router.put("/:id", updateStream);
router.delete("/:id", deleteStream);
export default router;
