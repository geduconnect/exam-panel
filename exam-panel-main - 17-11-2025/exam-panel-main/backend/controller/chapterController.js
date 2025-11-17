import pool from "../db.js";

export const getAllChapters = async (req, res) => {
  try {
    const { subject_id, category_id } = req.query;

    let sql = `
      SELECT chapters.*, 
             categories.name AS category_name,
             subjects.name AS subject_name,
             streams.name AS stream_name
      FROM chapters
      LEFT JOIN categories ON chapters.category_id = categories.id
      LEFT JOIN subjects ON chapters.subject_id = subjects.id
      LEFT JOIN streams ON subjects.stream_id = streams.id
      WHERE 1
    `;

    const params = [];
    if (subject_id) {
      sql += " AND chapters.subject_id = ?";
      params.push(subject_id);
    }
    if (category_id) {
      sql += " AND chapters.category_id = ?";
      params.push(category_id);
    }

    sql += " ORDER BY chapters.id DESC";

    const [rows] = await pool.query(sql, params);
    res.json(rows);
  } catch (err) {
    console.error("Error fetching chapters:", err);
    res.status(500).json({ error: "Failed to fetch chapters" });
  }
};



export const createChapter = async (req, res) => {
  const { name, subject_id, category_id } = req.body;
  if (!subject_id)
    return res.status(400).json({ error: "Subject is required" });

  try {
    await pool.query(
      "INSERT INTO chapters (name, subject_id, category_id) VALUES (?, ?, ?)",
      [name, subject_id, category_id || null]
    );
    res.json({ message: "Chapter added successfully" });
  } catch (err) {
    console.error("Error creating chapter:", err);
    res.status(500).json({ error: "Failed to create chapter" });
  }
};

export const updateChapter = async (req, res) => {
  const { id } = req.params;
  const { name } = req.body;
  try {
    await pool.query("UPDATE chapters SET name=? WHERE id=?", [name, id]);
    res.json({ message: "Chapter updated successfully" });
  } catch (err) {
    console.error("Error updating chapter:", err);
    res.status(500).json({ error: "Failed to update chapter" });
  }
};

export const deleteChapter = async (req, res) => {
  const { id } = req.params;
  try {
    await pool.query("DELETE FROM chapters WHERE id=?", [id]);
    res.json({ message: "Chapter deleted successfully" });
  } catch (err) {
    console.error("Error deleting chapter:", err);
    res.status(500).json({ error: "Failed to delete chapter" });
  }
};
