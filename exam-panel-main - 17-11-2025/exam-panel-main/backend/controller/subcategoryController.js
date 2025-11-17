import pool from "../db.js";

export const getAllSubcategories = async (req, res) => {
  try {
    const { stream_id, subject_id, category_id, chapter_id } = req.query;

    let query = `
      SELECT subcategories.*,
             chapters.name AS chapter_name,
             categories.name AS category_name,
             subjects.name AS subject_name,
             streams.name AS stream_name
      FROM subcategories
      LEFT JOIN chapters ON subcategories.chapter_id = chapters.id
      LEFT JOIN categories ON chapters.category_id = categories.id
      LEFT JOIN subjects ON categories.subject_id = subjects.id
      LEFT JOIN streams ON subjects.stream_id = streams.id
      WHERE 1
    `;
    const params = [];

    if (stream_id) {
      query += " AND streams.id = ?";
      params.push(stream_id);
    }
    if (subject_id) {
      query += " AND subjects.id = ?";
      params.push(subject_id);
    }
    if (category_id) {
      query += " AND categories.id = ?";
      params.push(category_id);
    }
    if (chapter_id) {
      query += " AND chapters.id = ?";
      params.push(chapter_id);
    }

    query += " ORDER BY subcategories.id DESC";

    const [rows] = await pool.query(query, params);
    res.json(rows);
  } catch (err) {
    console.error("Error fetching subcategories:", err);
    res.status(500).json({ error: "Failed to fetch subcategories" });
  }
};

export const createSubcategory = async (req, res) => {
  const { name, chapter_id } = req.body;
  if (!chapter_id) return res.status(400).json({ error: "Chapter is required" });

  try {
    await pool.query(
      "INSERT INTO subcategories (name, chapter_id) VALUES (?, ?)",
      [name, chapter_id]
    );
    res.json({ message: "Subcategory added successfully" });
  } catch (err) {
    console.error("Error creating subcategory:", err);
    res.status(500).json({ error: "Failed to create subcategory" });
  }
};

export const updateSubcategory = async (req, res) => {
  const { id } = req.params;
  const { name } = req.body;
  try {
    await pool.query("UPDATE subcategories SET name=? WHERE id=?", [name, id]);
    res.json({ message: "Subcategory updated successfully" });
  } catch (err) {
    console.error("Error updating subcategory:", err);
    res.status(500).json({ error: "Failed to update subcategory" });
  }
};

export const deleteSubcategory = async (req, res) => {
  const { id } = req.params;
  try {
    await pool.query("DELETE FROM subcategories WHERE id=?", [id]);
    res.json({ message: "Subcategory deleted successfully" });
  } catch (err) {
    console.error("Error deleting subcategory:", err);
    res.status(500).json({ error: "Failed to delete subcategory" });
  }
};
