import pool from "../db.js";

export const getAllSubjects = async (req, res) => {
  try {
    const { stream_id } = req.query;
    let query = `
      SELECT subjects.*, streams.name AS stream_name
      FROM subjects
      LEFT JOIN streams ON subjects.stream_id = streams.id
    `;
    const params = [];

    if (stream_id) {
      query += " WHERE subjects.stream_id = ?";
      params.push(stream_id);
    }

    query += " ORDER BY subjects.id DESC";

    const [rows] = await pool.query(query, params);
    res.json(rows);
  } catch (err) {
    console.error("Error fetching subjects:", err);
    res.status(500).json({ error: "Failed to fetch subjects" });
  }
};

export const createSubject = async (req, res) => {
  const { name, stream_id } = req.body;
  if (!stream_id) return res.status(400).json({ error: "Stream is required" });

  try {
    await pool.query("INSERT INTO subjects (name, stream_id) VALUES (?, ?)", [name, stream_id]);
    res.json({ message: "Subject added successfully" });
  } catch (err) {
    console.error("Error creating subject:", err);
    res.status(500).json({ error: "Failed to create subject" });
  }
};

export const updateSubject = async (req, res) => {
  const { id } = req.params;
  const { name } = req.body;
  try {
    await pool.query("UPDATE subjects SET name=? WHERE id=?", [name, id]);
    res.json({ message: "Subject updated successfully" });
  } catch (err) {
    console.error("Error updating subject:", err);
    res.status(500).json({ error: "Failed to update subject" });
  }
};

export const deleteSubject = async (req, res) => {
  const { id } = req.params;
  try {
    await pool.query("DELETE FROM subjects WHERE id=?", [id]);
    res.json({ message: "Subject deleted successfully" });
  } catch (err) {
    console.error("Error deleting subject:", err);
    res.status(500).json({ error: "Failed to delete subject" });
  }
};
