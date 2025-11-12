import pool from "../db.js";

// 🟢 Get All Categories (filtered by stream or subject)
export const getAllCategories = async (req, res) => {
  try {
    const { stream_id, subject_id } = req.query;

    let query = `
      SELECT 
        c.id, 
        c.name, 
        s.id AS subject_id,
        s.name AS subject_name,
        st.id AS stream_id,
        st.name AS stream_name
      FROM categories c
      INNER JOIN subjects s ON c.subject_id = s.id
      INNER JOIN streams st ON s.stream_id = st.id
      WHERE 1
    `;

    const params = [];

    if (stream_id) {
      query += " AND st.id = ?";
      params.push(stream_id);
    }

    if (subject_id) {
      query += " AND s.id = ?";
      params.push(subject_id);
    }

    query += " ORDER BY c.id DESC";

    const [rows] = await pool.query(query, params);
    res.json(rows);
  } catch (err) {
    console.error("❌ Error fetching categories:", err);
    res.status(500).json({ error: "Failed to fetch categories" });
  }
};

// 🟢 Create Category
export const createCategory = async (req, res) => {
  const { name, subject_id } = req.body;
  if (!subject_id) return res.status(400).json({ error: "Subject is required" });

    try {
    // optional: prevent duplicate under same subject
    const [exists] = await pool.query(
      "SELECT id FROM categories WHERE name=? AND subject_id=?",
      [name, subject_id]
    );
    if (exists.length > 0)
      return res.status(400).json({ error: "Category already exists for this subject" });

    await pool.query(
      "INSERT INTO categories (name, subject_id) VALUES (?, ?)",
      [name, subject_id]
    );
    res.json({ message: "Category added successfully" });
  } catch (err) {
    console.error("❌ Error creating category:", err);
    res.status(500).json({ error: "Failed to create category" });
  }
};

// 🟢 Update Category
export const updateCategory = async (req, res) => {
  const { id } = req.params;
  const { name } = req.body;

  try {
    await pool.query("UPDATE categories SET name=? WHERE id=?", [name, id]);
    res.json({ message: "Category updated successfully" });
  } catch (err) {
    console.error("❌ Error updating category:", err);
    res.status(500).json({ error: "Failed to update category" });
  }
};

// 🟢 Delete Category
export const deleteCategory = async (req, res) => {
  const { id } = req.params;
  try {
    await pool.query("DELETE FROM categories WHERE id=?", [id]);
    res.json({ message: "Category deleted successfully" });
  } catch (err) {
    console.error("❌ Error deleting category:", err);
    res.status(500).json({ error: "Failed to delete category" });
  }
};
