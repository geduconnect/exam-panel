// src/pages/HierarchyManager.jsx
import React, { useState } from "react";
import StreamTable from "../../components/elements/stream/StreamTable";
import SubjectTable from "../../components/elements/subject/SubjectTable";
import CategoryTable from "../../components/elements/category/CategoryTable";
import ChapterTable from "../../components/elements/chapter/ChapterTable";
import SubCategoryTable from "../../components/elements/sub-category/SubCategoryTable";

export default function HierarchyManager() {
  const [selected, setSelected] = useState("");

  const handleSelect = (e) => {
    setSelected(e.target.value);
  };

  return (
    <div style={{ padding: "20px" }}>
      <h2>Hierarchy Manager</h2>

      {/* Dropdown Menu */}
      <select
        onChange={handleSelect}
        value={selected}
        style={{
          padding: "8px",
          width: "250px",
          marginBottom: "20px",
        }}
      >
        <option value="">Select Section</option>
        <option value="stream">Stream</option>
        <option value="subject">Subject</option>
        <option value="category">Category</option>
        <option value="chapter">Chapter</option>
        <option value="subcategory">Sub-Category</option>
      </select>

      {/* Dynamic Page Load */}
      <div style={{ marginTop: "20px" }}>
        {selected === "stream" && <StreamTable />}
        {selected === "subject" && <SubjectTable />}
        {selected === "category" && <CategoryTable />}
        {selected === "chapter" && <ChapterTable />}
        {selected === "subcategory" && <SubCategoryTable />}
      </div>
    </div>
  );
}
