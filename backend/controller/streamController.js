import pool from "../db.js"; // ✅ make sure this path is correct

export const getAllStreams = async (req, res) => {
  try {
    const [rows] = await pool.query("SELECT * FROM streams ORDER BY id DESC");
    res.json(rows);
  } catch (err) {
    console.error("❌ Error fetching streams:", err);
    res.status(500).json({ error: "Failed to fetch streams", details: err.message });
  }
};

export const createStream = async (req, res) => {
  const { name } = req.body;
  try {
    if (!name) return res.status(400).json({ error: "Stream name is required" });
    await pool.query("INSERT INTO streams (name) VALUES (?)", [name]);
    res.json({ message: "Stream added successfully" });
  } catch (err) {
    console.error("❌ Error creating stream:", err);
    res.status(500).json({ error: "Failed to create stream", details: err.message });
  }
};

export const updateStream = async (req, res) => {
  const { id } = req.params;
  const { name } = req.body;
  try {
    await pool.query("UPDATE streams SET name = ? WHERE id = ?", [name, id]);
    res.json({ message: "Stream updated successfully" });
  } catch (err) {
    console.error("❌ Error updating stream:", err);
    res.status(500).json({ error: "Failed to update stream", details: err.message });
  }
};

export const deleteStream = async (req, res) => {
  const { id } = req.params;
  try {
    await pool.query("DELETE FROM streams WHERE id = ?", [id]);
    res.json({ message: "Stream deleted successfully" });
  } catch (err) {
    console.error("❌ Error deleting stream:", err);
    res.status(500).json({ error: "Failed to delete stream", details: err.message });
  }
};
