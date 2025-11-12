import React, { useEffect, useState } from "react";
import api from "../api";
import * as XLSX from "xlsx";

export default function QuestionManager() {
  const [streams, setStreams] = useState([]);
  const [subjects, setSubjects] = useState([]);
  const [chapters, setChapters] = useState([]);
  const [questions, setQuestions] = useState([]);

  const [selectedStream, setSelectedStream] = useState("");
  const [selectedSubject, setSelectedSubject] = useState("");
  const [selectedChapter, setSelectedChapter] = useState("");
  const [selectedLevel, setSelectedLevel] = useState("");
  const [searchTerm, setSearchTerm] = useState("");

  const [selectedIds, setSelectedIds] = useState([]); // ✅ Bulk select
  const [currentPage, setCurrentPage] = useState(1);
  const [questionsPerPage] = useState(10);

  // Add/Edit state
  const [questionData, setQuestionData] = useState({
    question: "",
    option_a: "",
    option_b: "",
    option_c: "",
    option_d: "",
    correct_answer: "",
    explanation: "",
    level: "",
  });
  const [editId, setEditId] = useState(null);

  useEffect(() => {
    fetchStreams();
    fetchQuestions();
  }, []);

  const fetchStreams = async () => {
    const res = await api.get("/admin/streams");
    setStreams(res.data);
  };

  const fetchSubjects = async (streamId) => {
    const res = await api.get(`/admin/subjects?stream_id=${streamId}`);
    setSubjects(res.data);
  };

  const fetchChapters = async (subjectId) => {
    const res = await api.get(`/admin/chapters?subject_id=${subjectId}`);
    setChapters(res.data);
  };

  const fetchQuestions = async () => {
    try {
      const res = await api.get("/admin/questions");
      setQuestions(res.data);
    } catch (err) {
      console.error("❌ Error fetching questions:", err);
    }
  };

  // Handle cascading dropdowns
  const handleStreamChange = (e) => {
    const id = e.target.value;
    setSelectedStream(id);
    setSelectedSubject("");
    setSelectedChapter("");
    if (id) fetchSubjects(id);
  };

  const handleSubjectChange = (e) => {
    const id = e.target.value;
    setSelectedSubject(id);
    if (id) fetchChapters(id);
  };

  // Handle input
  const handleChange = (e) => {
    setQuestionData({ ...questionData, [e.target.name]: e.target.value });
  };

  // Add or update
  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      if (editId) {
        await api.put(`/admin/questions/${editId}`, questionData);
        alert("✅ Question updated successfully!");
      } else {
        await api.post("/admin/questions", {
          ...questionData,
          stream_id: selectedStream,
          subject_id: selectedSubject,
          chapter_id: selectedChapter,
        });
        alert("✅ Question added successfully!");
      }
      setQuestionData({
        question: "",
        option_a: "",
        option_b: "",
        option_c: "",
        option_d: "",
        correct_answer: "",
        explanation: "",
        level: "",
      });
      setEditId(null);
      fetchQuestions();
    } catch (err) {
      console.error("❌ Error saving question:", err);
    }
  };

  // Edit
  const handleEdit = (q) => {
    setEditId(q.id);
    setQuestionData({
      question: q.question,
      option_a: q.option_a,
      option_b: q.option_b,
      option_c: q.option_c,
      option_d: q.option_d,
      correct_answer: q.correct_answer,
      explanation: q.explanation,
      level: q.level,
    });
  };

  // Delete or Bulk Delete
  const handleDelete = async (id) => {
    if (!window.confirm("Delete this question?")) return;
    await api.delete(`/admin/questions/${id}`);
    fetchQuestions();
  };

  const handleBulkDelete = async () => {
    if (selectedIds.length === 0) return alert("Select questions to delete");
    if (!window.confirm(`Delete ${selectedIds.length} questions?`)) return;
    await api.post("/admin/questions/bulk-delete", { ids: selectedIds });
    setSelectedIds([]);
    fetchQuestions();
  };

  // Export to Excel
  const exportToExcel = () => {
    const worksheet = XLSX.utils.json_to_sheet(questions);
    const workbook = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(workbook, worksheet, "Questions");
    XLSX.writeFile(workbook, "questions_export.xlsx");
  };

  // Import from Excel
  const importFromExcel = async (e) => {
    const file = e.target.files[0];
    if (!file) return;
    const data = await file.arrayBuffer();
    const workbook = XLSX.read(data);
    const sheet = workbook.Sheets[workbook.SheetNames[0]];
    const json = XLSX.utils.sheet_to_json(sheet);
    await api.post("/admin/questions/import", json);
    fetchQuestions();
  };

  // Filters + Search
  const filtered = questions.filter((q) => {
    return (
      (!selectedStream || q.stream_id == selectedStream) &&
      (!selectedSubject || q.subject_id == selectedSubject) &&
      (!selectedChapter || q.chapter_id == selectedChapter) &&
      (!selectedLevel || q.level === selectedLevel) &&
      q.question.toLowerCase().includes(searchTerm.toLowerCase())
    );
  });

  const startIndex = (currentPage - 1) * questionsPerPage;
  const currentQuestions = filtered.slice(
    startIndex,
    startIndex + questionsPerPage
  );

  // Select checkbox
  const toggleSelect = (id) => {
    setSelectedIds((prev) =>
      prev.includes(id) ? prev.filter((x) => x !== id) : [...prev, id]
    );
  };

  return (
    <div className="p-8 bg-gray-50 min-h-screen">
      <h2 className="text-2xl font-bold mb-4 text-center">
        🧩 Question Manager
      </h2>

      {/* Filters */}
      <div className="flex flex-wrap gap-4 justify-center mb-6">
        <input
          type="text"
          placeholder="Search question..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="border p-2 rounded w-64"
        />
        <select
          value={selectedStream}
          onChange={handleStreamChange}
          className="border p-2 rounded"
        >
          <option value="">All Streams</option>
          {streams.map((s) => (
            <option key={s.id} value={s.id}>
              {s.name}
            </option>
          ))}
        </select>
        <select
          value={selectedSubject}
          onChange={handleSubjectChange}
          className="border p-2 rounded"
        >
          <option value="">All Subjects</option>
          {subjects.map((s) => (
            <option key={s.id} value={s.id}>
              {s.name}
            </option>
          ))}
        </select>
        <select
          value={selectedChapter}
          onChange={(e) => setSelectedChapter(e.target.value)}
          className="border p-2 rounded"
        >
          <option value="">All Chapters</option>
          {chapters.map((c) => (
            <option key={c.id} value={c.id}>
              {c.name}
            </option>
          ))}
        </select>
        <select
          value={selectedLevel}
          onChange={(e) => setSelectedLevel(e.target.value)}
          className="border p-2 rounded"
        >
          <option value="">All Levels</option>
          <option value="easy">Easy</option>
          <option value="medium">Medium</option>
          <option value="hard">Hard</option>
        </select>
      </div>

      {/* Add / Edit Form */}
      <div className="bg-white p-6 rounded-xl shadow-md max-w-4xl mx-auto mb-10">
        <form onSubmit={handleSubmit} className="space-y-3">
          <input
            name="question"
            placeholder="Enter question"
            value={questionData.question}
            onChange={handleChange}
            className="border p-2 rounded w-full"
            required
          />
          {["a", "b", "c", "d"].map((opt) => (
            <input
              key={opt}
              name={`option_${opt}`}
              placeholder={`Option ${opt.toUpperCase()}`}
              value={questionData[`option_${opt}`]}
              onChange={handleChange}
              className="border p-2 rounded w-full"
            />
          ))}
          <input
            name="correct_answer"
            placeholder="Correct Answer"
            value={questionData.correct_answer}
            onChange={handleChange}
            className="border p-2 rounded w-full"
          />
          <textarea
            name="explanation"
            placeholder="Explanation"
            value={questionData.explanation}
            onChange={handleChange}
            className="border p-2 rounded w-full"
            rows="3"
          />
          <select
            name="level"
            value={questionData.level}
            onChange={handleChange}
            className="border p-2 rounded w-full"
          >
            <option value="">Select Difficulty</option>
            <option value="easy">Easy</option>
            <option value="medium">Medium</option>
            <option value="hard">Hard</option>
          </select>

          <button
            type="submit"
            className="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700"
          >
            {editId ? "Update Question" : "Add Question"}
          </button>
        </form>
      </div>

      {/* Table */}
      <div className="bg-white p-6 rounded-xl shadow-md max-w-6xl mx-auto">
        <div className="flex justify-between mb-3">
          <h3 className="text-xl font-semibold">All Questions</h3>
          <div className="flex gap-2">
            <button
              onClick={exportToExcel}
              className="bg-green-600 text-white px-3 py-1 rounded"
            >
              Export
            </button>
            <label className="bg-yellow-600 text-white px-3 py-1 rounded cursor-pointer">
              Import
              <input
                type="file"
                accept=".xlsx, .xls"
                onChange={importFromExcel}
                hidden
              />
            </label>
            <button
              onClick={handleBulkDelete}
              className="bg-red-600 text-white px-3 py-1 rounded"
            >
              Delete Selected
            </button>
          </div>
        </div>

        <table className="w-full border text-sm">
          <thead className="bg-gray-100">
            <tr>
              <th className="p-2 border">Select</th>
              <th className="p-2 border">Question</th>
              <th className="p-2 border">Correct</th>
              <th className="p-2 border">Level</th>
              <th className="p-2 border">Actions</th>
            </tr>
          </thead>
          <tbody>
            {currentQuestions.map((q) => (
              <tr key={q.id}>
                <td className="border p-2 text-center">
                  <input
                    type="checkbox"
                    checked={selectedIds.includes(q.id)}
                    onChange={() => toggleSelect(q.id)}
                  />
                </td>
                <td className="border p-2">{q.question}</td>
                <td className="border p-2">{q.correct_answer}</td>
                <td className="border p-2 capitalize">{q.level}</td>
                <td className="border p-2 space-x-2">
                  <button
                    onClick={() => handleEdit(q)}
                    className="bg-yellow-500 text-white px-3 py-1 rounded"
                  >
                    Edit
                  </button>
                  <button
                    onClick={() => handleDelete(q.id)}
                    className="bg-red-500 text-white px-3 py-1 rounded"
                  >
                    Delete
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>

        {/* Pagination */}
        <div className="flex justify-center gap-4 mt-4">
          <button
            disabled={currentPage === 1}
            onClick={() => setCurrentPage(currentPage - 1)}
            className="px-4 py-2 border rounded disabled:opacity-50"
          >
            Prev
          </button>
          <span className="py-2">
            Page {currentPage} of {Math.ceil(filtered.length / questionsPerPage)}
          </span>
          <button
            disabled={
              currentPage === Math.ceil(filtered.length / questionsPerPage)
            }
            onClick={() => setCurrentPage(currentPage + 1)}
            className="px-4 py-2 border rounded disabled:opacity-50"
          >
            Next
          </button>
        </div>
      </div>
    </div>
  );
}
