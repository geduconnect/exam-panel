import React, { useEffect, useState } from "react";
import api from "../../api";
export default function CreateManualTest() {
  const [questions, setQuestions] = useState([]);
  const [filtered, setFiltered] = useState([]);
  const [subjects, setSubjects] = useState([]);
  const [streams, setStreams] = useState([]);
  const [chapters, setChapters] = useState([]);
  const [selectedIds, setSelectedIds] = useState([]);
  const [filters, setFilters] = useState({
    stream_id: "",
    subject_id: "",
    chapter_id: "",
    level: "",
  });
  const [form, setForm] = useState({
    name: "",
    stream_id: "",
    set_name: "A",
    total_duration: 90,
  });

  // Fetch questions
  useEffect(() => {
    fetchQuestions();
  }, []);

  const fetchQuestions = async () => {
    try {
      const res = await api.get("/admin/questions");
      const q = res.data || [];
      setQuestions(q);
      setFiltered(q);

      // Populate dropdowns dynamically
      const streamList = [
        ...new Map(q.map((i) => [i.stream_id, i.stream_name])).entries(),
      ];
      setStreams(streamList);

      const subjectList = [
        ...new Map(q.map((i) => [i.subject_id, i.subject_name])).entries(),
      ];
      setSubjects(subjectList);

      const chapterList = [
        ...new Map(q.map((i) => [i.chapter_id, i.chapter_name])).entries(),
      ];
      setChapters(chapterList);
    } catch (err) {
      console.error("Error fetching questions:", err);
    }
  };

  // Handle filter changes
  const handleFilter = (key, value) => {
    setFilters((prev) => ({ ...prev, [key]: value }));
  };

  // Apply filters
  useEffect(() => {
    let data = [...questions];

    if (filters.stream_id)
      data = data.filter((q) => q.stream_id === Number(filters.stream_id));

    if (filters.subject_id)
      data = data.filter((q) => q.subject_id === Number(filters.subject_id));

    if (filters.chapter_id)
      data = data.filter((q) => q.chapter_id === Number(filters.chapter_id));

    if (filters.level)
      data = data.filter((q) => (q.level || "medium") === filters.level);

    setFiltered(data);
  }, [filters, questions]);

  // Handle checkbox
  const toggleQuestion = (id) => {
    setSelectedIds((prev) =>
      prev.includes(id) ? prev.filter((x) => x !== id) : [...prev, id]
    );
  };

  // Handle form input
  const handleInput = (e) => {
    const { name, value } = e.target;
    setForm((prev) => ({ ...prev, [name]: value }));
  };

  // Submit create test
  const handleSubmit = async () => {
    if (!form.name || !form.stream_id || selectedIds.length === 0) {
      alert("Please fill all required fields and select at least one question");
      return;
    }

    try {
      const res = await api.post("/admin/tests/create-manual", {
        ...form,
        question_ids: selectedIds,
      });

      alert(res.data.message || "Test created successfully!");
      setSelectedIds([]);
    } catch (err) {
      console.error("Create test error:", err);
      alert(err.response?.data?.message || "Failed to create test");
    }
  };

  return (
    <div className="p-6">
      <h2 className="text-2xl font-bold mb-4">🧩 Create Manual Test Set</h2>

      {/* Form Inputs */}
      <div className="grid grid-cols-4 gap-3 mb-4">
        <input
          type="text"
          name="name"
          placeholder="Test Name"
          value={form.name}
          onChange={handleInput}
          className="border p-2 rounded"
        />

        <input
          type="text"
          name="set_name"
          placeholder="Set Name (A/B/C)"
          value={form.set_name}
          onChange={handleInput}
          className="border p-2 rounded"
        />

        <select
          name="stream_id"
          value={form.stream_id}
          onChange={handleInput}
          className="border p-2 rounded"
        >
          <option value="">Select Stream</option>
          {streams.map(([id, name]) => (
            <option key={id} value={id}>
              {name}
            </option>
          ))}
        </select>

        <input
          type="number"
          name="total_duration"
          placeholder="Duration (mins)"
          value={form.total_duration}
          onChange={handleInput}
          className="border p-2 rounded"
        />
      </div>

      {/* Filters */}
      <div className="flex items-center gap-4 mb-4">
        <select
          value={filters.stream_id}
          onChange={(e) => handleFilter("stream_id", e.target.value)}
          className="border p-2 rounded"
        >
          <option value="">All Streams</option>
          {streams.map(([id, name]) => (
            <option key={id} value={id}>
              {name}
            </option>
          ))}
        </select>

        <select
          value={filters.subject_id}
          onChange={(e) => handleFilter("subject_id", e.target.value)}
          className="border p-2 rounded"
        >
          <option value="">All Subjects</option>
          {subjects.map(([id, name]) => (
            <option key={id} value={id}>
              {name}
            </option>
          ))}
        </select>

        <select
          value={filters.chapter_id}
          onChange={(e) => handleFilter("chapter_id", e.target.value)}
          className="border p-2 rounded"
        >
          <option value="">All Chapters</option>
          {chapters.map(([id, name]) => (
            <option key={id} value={id}>
              {name}
            </option>
          ))}
        </select>

        <select
          value={filters.level}
          onChange={(e) => handleFilter("level", e.target.value)}
          className="border p-2 rounded"
        >
          <option value="">All Levels</option>
          <option value="easy">Easy</option>
          <option value="medium">Medium</option>
          <option value="hard">Hard</option>
        </select>
      </div>

      {/* Table */}
      <div className="overflow-x-auto border rounded-lg shadow-md">
        <table className="w-full border-collapse">
          <thead className="bg-gray-200">
            <tr>
              <th className="p-2">Select</th>
              <th className="p-2">ID</th>
              <th className="p-2">Subject</th>
              <th className="p-2">Chapter</th>
              <th className="p-2">Level</th>
              <th className="p-2">Question</th>
            </tr>
          </thead>
          <tbody>
            {filtered.map((q) => (
              <tr key={q.id} className="border-b hover:bg-gray-50">
                <td className="p-2 text-center">
                  <input
                    type="checkbox"
                    checked={selectedIds.includes(q.id)}
                    onChange={() => toggleQuestion(q.id)}
                  />
                </td>
                <td className="p-2">{q.id}</td>
                <td className="p-2">{q.subject_name}</td>
                <td className="p-2">{q.chapter_name}</td>
                <td className="p-2 capitalize">{q.level || "medium"}</td>
                <td className="p-2">{q.question_text || q.question}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <div className="flex justify-between mt-4">
        <span className="text-sm text-gray-600">
          Selected: {selectedIds.length}
        </span>
        <button
          onClick={handleSubmit}
          className="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700"
        >
          Create Test
        </button>
      </div>
    </div>
  );
}