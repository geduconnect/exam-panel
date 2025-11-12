import React, { useEffect, useState } from "react";
import * as XLSX from "xlsx";
import api from "../../api";

export default function QuestionList() {
  const [questions, setQuestions] = useState([]);
  const [selectedIds, setSelectedIds] = useState([]);
  const [searchTerm, setSearchTerm] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [questionsPerPage] = useState(10);
  const [loading, setLoading] = useState(false);

  // Filters
  const [streams, setStreams] = useState([]);
  const [subjects, setSubjects] = useState([]);
  const [categories, setCategories] = useState([]);
  const [chapters, setChapters] = useState([]);
  const [subCategories, setSubCategories] = useState([]);

  const [selectedStream, setSelectedStream] = useState("");
  const [selectedSubject, setSelectedSubject] = useState("");
  const [selectedCategory, setSelectedCategory] = useState("");
  const [selectedChapter, setSelectedChapter] = useState("");
  const [selectedSubCategory, setSelectedSubCategory] = useState("");
  const [selectedLevel, setSelectedLevel] = useState("");

  // Modal
  const [showModal, setShowModal] = useState(false);

  useEffect(() => {
    fetchQuestions();
    fetchStreams();
    fetchCategories();
  }, []);

  const fetchStreams = async () => {
    try {
      const res = await api.get("/admin/streams");
      setStreams(res.data);
    } catch (err) {
      console.error("❌ Error fetching streams:", err);
    }
  };

  const fetchSubjects = async (streamId) => {
    try {
      const res = await api.get(`/admin/subjects?stream_id=${streamId}`);
      setSubjects(res.data);
    } catch (err) {
      console.error("❌ Error fetching subjects:", err);
    }
  };

  const fetchCategories = async (subjectId) => {
    try {
      const res = await api.get(`/admin/categories?subject_id=${subjectId}`);
      setCategories(res.data);
    } catch (err) {
      console.error("❌ Error fetching categories:", err);
    }
  };
  const fetchChapters = async (categoryId) => {
    try {
      const res = await api.get(`/admin/chapters?category_id=${categoryId}`);
      setChapters(res.data);
    } catch (err) {
      console.error("❌ Error fetching chapters:", err);
    }
  };
  const fetchSubCategories = async (chapterId) => {
    try {
      const res = await api.get(`/admin/subcategories?chapter_id=${chapterId}`);
      setSubCategories(res.data);
    } catch (err) {
      console.error("❌ Error fetching subcategories:", err);
    }
  };
  const handleStreamChange = (e) => {
    const id = e.target.value;
    setSelectedStream(id);
    setSelectedSubject("");
    setSelectedCategory("");
    setSelectedChapter("");
    setSelectedSubCategory("");
    setSubjects([]);
    setCategories([]);
    setChapters([]);
    setSubCategories([]);
    if (id) fetchSubjects(id);
  };

  const handleSubjectChange = (e) => {
    const id = e.target.value;
    setSelectedSubject(id);
    setSelectedCategory("");
    setSelectedChapter("");
    setSelectedSubCategory("");
    setCategories([]);
    setChapters([]);
    setSubCategories([]);
    if (id) fetchCategories(id);
  };
  const handleCategoryChange = (e) => {
    const id = e.target.value;
    console.log("Selected category:", id);
    setSelectedCategory(id);
    setSelectedChapter("");
    setSelectedSubCategory("");
    setChapters([]);
    setSubCategories([]);
    if (id) fetchChapters(id);
  };


  const handleChapterChange = (e) => {
    const id = e.target.value;
    setSelectedChapter(id);
    setSelectedSubCategory("");
    setSubCategories([]);
    if (id) fetchSubCategories(id);
  };
  const fetchQuestions = async () => {
    setLoading(true);
    try {
      const res = await api.get("/admin/questions");
      setQuestions(res.data || []);
    } catch (err) {
      console.error("❌ Error fetching questions:", err);
      alert("Failed to load questions");
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id) => {
    if (!window.confirm("🗑️ Delete this question?")) return;
    try {
      await api.delete(`/admin/questions/${id}`);
      fetchQuestions();
    } catch (err) {
      alert("Failed to delete question");
      console.error(err);
    }
  };

  const toggleSelect = (id) => {
    setSelectedIds((prev) =>
      prev.includes(id) ? prev.filter((x) => x !== id) : [...prev, id]
    );
  };

  // ✅ Excel Import (with optional image columns)
  const handleImportExcel = async (e) => {
    const file = e.target.files[0];
    if (!file) return;

    if (!selectedStream) return alert("⚠️ Select a Stream before uploading!");
    if (!selectedSubject) return alert("⚠️ Select a Subject before uploading!");
    if (!selectedCategory) return alert("⚠️ Select a Category before uploading!");
    if (!selectedChapter) return alert("⚠️ Select a Chapter before uploading!");

    try {
      setLoading(true);
      const formData = new FormData();
      formData.append("file", file); // must match multer.single("file")
      formData.append("stream_id", selectedStream);
      formData.append("subject_id", selectedSubject);
      formData.append("category_id", selectedCategory);
      formData.append("chapter_id", selectedChapter);
      if (selectedSubCategory)
        formData.append("subcategory_id", selectedSubCategory);
   await api.post("/admin/questions/import-questions", formData, {
  headers: { "Content-Type": "multipart/form-data" },
});

      alert("✅ Questions imported successfully!");
      setShowModal(false);
      fetchQuestions();
    } catch (err) {
      console.error("❌ Import failed:", err);
      alert("Import failed — check Excel format or backend connection.");
    } finally {
      setLoading(false);
      e.target.value = "";
    }
  };

  // Filtering logic
  const filtered = questions.filter((q) => {
    return (
      (!selectedStream || q.stream_id == selectedStream) &&
      (!selectedSubject || q.subject_id == selectedSubject) &&
      (!selectedCategory || q.category_id == selectedCategory) &&
      (!selectedChapter || q.chapter_id == selectedChapter) &&
      (!selectedSubCategory || q.subcategory_id == selectedSubCategory) &&
      (!selectedLevel || q.level == selectedLevel) &&
      q.question?.toLowerCase().includes(searchTerm.toLowerCase())
    );
  });

  const startIndex = (currentPage - 1) * questionsPerPage;
  const currentQuestions = filtered.slice(startIndex, startIndex + questionsPerPage);

  return (
    <div className="p-8 bg-gray-50 min-h-screen">
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold">📋 Question List</h2>
        <button
          onClick={() => setShowModal(true)}
          className="bg-green-600 text-white px-4 py-2 rounded"
        >
          📤 Import Questions
        </button>
      </div>

      {/* Filter Bar */}
      <div className="filters-container flex flex-wrap gap-2 mb-4">
        {[{
          label: "Stream", value: selectedStream, onChange: handleStreamChange, list: streams
        }, {
          label: "Subject", value: selectedSubject, onChange: handleSubjectChange, list: subjects
        }, {
          label: "Category",
          value: selectedCategory,
          onChange: handleCategoryChange,
          list: categories
        }, {
          label: "Chapter", value: selectedChapter, onChange: handleChapterChange, list: chapters
        }, {
          label: "Sub Category", value: selectedSubCategory, onChange: (e) => setSelectedSubCategory(e.target.value), list: subCategories
        }].map((f) => (
          <select key={f.label} value={f.value} onChange={f.onChange}>
            <option value="">{f.label}</option>
            {f.list.map((x) => (
              <option key={x.id} value={x.id}>
                {x.name}
              </option>
            ))}
          </select>
        ))}

        <select
          value={selectedLevel}
          onChange={(e) => setSelectedLevel(e.target.value)}
        >
          <option value="">Level</option>
          <option value="easy">Easy</option>
          <option value="moderate">Moderate</option>
          <option value="hard">Hard</option>
        </select>

        <input
          type="text"
          placeholder="🔍 Search question"
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
        />
      </div>

      {/* Table */}
      <div className="bg-white p-6 rounded-xl shadow-md overflow-x-auto">
        {loading ? (
          <p className="text-center py-4">⏳ Loading...</p>
        ) : (
          <table className="w-full border text-sm min-w-[900px]">
            <thead className="bg-gray-100">
              <tr>
                <th>Select</th>
                <th>Question</th>
                <th>Options</th>
                <th>Answer</th>
                <th>Level</th>
                <th>Explanation</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {currentQuestions.length > 0 ? (
                currentQuestions.map((q) => (
                  <tr key={q.id}>
                    <td>
                      <input
                        type="checkbox"
                        checked={selectedIds.includes(q.id)}
                        onChange={() => toggleSelect(q.id)}
                      />
                    </td>

                    {/* Question & Image */}
                    <td>
                      <div className="flex flex-col">
                        <span>{q.question}</span>
                        {q.question_image && (
                          <img
                            src={`http://localhost:5000/uploads/questions/${q.question_image}`}
                            alt="Question"
                            width="80"
                            className="mt-1 rounded border"
                          />
                        )}
                      </div>
                    </td>

                    {/* Options + Optional Images */}
                    <td>
                      {["a", "b", "c", "d"].map((opt) => (
                        <div key={opt} className="mb-1">
                          <strong>{opt.toUpperCase()}:</strong> {q[`option_${opt}`]}
                          {q[`option_${opt}_image`] && (
                            <img
                              src={`http://localhost:5000/uploads/questions/${q[`option_${opt}_image`]}`}
                              alt={`Option ${opt}`}
                              width="70"
                              className="mt-1 rounded border"
                            />
                          )}
                        </div>
                      ))}
                    </td>

                    <td>{q.correct_answer}</td>
                    <td>{q.level}</td>
                    <td>{q.explanation || "-"}</td>
                    <td>
                      <button
                        className="text-blue-600 mr-2"
                        onClick={() => alert("Edit coming soon!")}
                      >
                        Edit
                      </button>
                      <button
                        className="text-red-600"
                        onClick={() => handleDelete(q.id)}
                      >
                        Delete
                      </button>
                    </td>
                  </tr>
                ))
              ) : (
                <tr>
                  <td colSpan="7" className="text-center py-4">
                    No questions found
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        )}
      </div>

      {/* Pagination */}
      {filtered.length > questionsPerPage && (
        <div className="flex justify-center gap-2 mt-4">
          <button
            onClick={() => setCurrentPage((p) => Math.max(p - 1, 1))}
            disabled={currentPage === 1}
            className="px-3 py-1 bg-gray-200 rounded disabled:opacity-50"
          >
            ⬅ Prev
          </button>

          {Array.from(
            { length: Math.ceil(filtered.length / questionsPerPage) },
            (_, i) => (
              <button
                key={i + 1}
                onClick={() => setCurrentPage(i + 1)}
                className={`px-3 py-1 rounded ${currentPage === i + 1
                  ? "bg-blue-600 text-white"
                  : "bg-gray-200 hover:bg-gray-300"
                  }`}
              >
                {i + 1}
              </button>
            )
          )}

          <button
            onClick={() =>
              setCurrentPage((p) =>
                Math.min(p + 1, Math.ceil(filtered.length / questionsPerPage))
              )
            }
            disabled={currentPage === Math.ceil(filtered.length / questionsPerPage)}
            className="px-3 py-1 bg-gray-200 rounded disabled:opacity-50"
          >
            Next ➡
          </button>
        </div>
      )}

      {/* Import Modal */}
      {showModal && (
        <div className="modal-overlay">
          <div className="modal">
            <h3>📥 Import Questions</h3>
            <select value={selectedStream} onChange={handleStreamChange}>
              <option value="">Select Stream</option>
              {streams.map((s) => (
                <option key={s.id} value={s.id}>{s.name}</option>
              ))}
            </select>

            <select value={selectedSubject} onChange={handleSubjectChange}>
              <option value="">Select Subject</option>
              {subjects.map((s) => (
                <option key={s.id} value={s.id}>{s.name}</option>
              ))}
            </select>

            <select value={selectedCategory} onChange={handleCategoryChange}>
              <option value="">Select Category</option>
              {categories.map((c) => (
                <option key={c.id} value={c.id}>{c.name}</option>
              ))}
            </select>

            <select value={selectedChapter} onChange={handleChapterChange}>
              <option value="">Select Chapter</option>
              {chapters.map((ch) => (
                <option key={ch.id} value={ch.id}>{ch.name}</option>
              ))}
            </select>


            <input
              type="file"
              accept=".xlsx,.xls,.csv"
              onChange={handleImportExcel}
              disabled={
                !selectedStream ||
                !selectedSubject ||
                !selectedCategory ||
                !selectedChapter
              }
            />

            <div className="modal-actions">
              <button onClick={() => setShowModal(false)} className="cancel-btn">
                Cancel
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
