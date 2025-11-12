import React, { useState, useEffect } from "react";
import api from "../api";

export default function BalancedTestCreator() {
  const [streams, setStreams] = useState([]);
  const [students, setStudents] = useState([]);
  const [previewData, setPreviewData] = useState([]);
  const [message, setMessage] = useState("");
  const [loading, setLoading] = useState(false);

  const [form, setForm] = useState({
    name: "",
    stream_id: "",
    totalQuestions: 90,
    randomize: true,
    assignTo: "stream",
    assignId: "",
  });

  // 🔹 Fetch Streams
  useEffect(() => {
    api
      .get("/admin/streams")
      .then((res) => setStreams(res.data || []))
      .catch((err) => {
        console.error("Error fetching streams:", err);
        setStreams([]);
      });
  }, []);

  // 🔹 Fetch Students (when assignTo = student)
  useEffect(() => {
    if (form.assignTo === "student" && form.stream_id) {
      api
        .get(`/admin/students?stream_id=${form.stream_id}`)
        .then((res) => setStudents(res.data || []))
        .catch((err) => {
          console.error("Error fetching students:", err);
          setStudents([]);
        });
    } else {
      setStudents([]);
    }
  }, [form.stream_id, form.assignTo]);

  // 🔹 Handle Input Changes
  const handleChange = (e) => {
    const { name, value } = e.target;
    setForm((prev) => ({
      ...prev,
      [name]: value,
      ...(name === "assignTo" ? { assignId: "" } : {}),
    }));
  };

  // 🔹 Preview Question Distribution
  const handlePreview = async () => {
    if (!form.stream_id) {
      setMessage("⚠️ Please select a stream first.");
      return;
    }

    setLoading(true);
    setMessage("");
    setPreviewData([]);

    try {
   const res = await api.get(`/admin/balanced-tests/preview?stream_id=${form.stream_id}`);
      const distribution = res.data?.distribution || [];
      if (distribution.length > 0) {
        setPreviewData(distribution);
        setMessage("✅ Preview generated successfully.");
      } else {
        setMessage("⚠️ No questions available for this stream.");
      }
    } catch (err) {
      console.error("Preview error:", err);
      setMessage("❌ Failed to load preview. Check console for details.");
    } finally {
      setLoading(false);
    }
  };

  // 🔹 Submit Test Creation
  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!form.name.trim() || !form.stream_id) {
      setMessage("⚠️ Please enter test name and select a stream.");
      return;
    }

    setLoading(true);
    setMessage("");

    const payload = {
      name: form.name.trim(),
      stream_id: form.stream_id,
      total_questions: form.totalQuestions || 90,
      randomize: form.randomize,
      assigned_to: form.assignTo,
      assigned_id:
        form.assignTo === "student" ? form.assignId : form.stream_id,
    };

    try {
    const res = await api.post("/admin/balanced-tests/create-balanced", payload);

      setMessage(`✅ Test created successfully (ID: ${res.data.test_id})`);
      setForm({
        name: "",
        stream_id: "",
        totalQuestions: 90,
        randomize: true,
        assignTo: "stream",
        assignId: "",
      });
      setPreviewData([]);
    } catch (err) {
      console.error("❌ Error creating test:", err);
      setMessage("❌ Failed to create test. Check console for details.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="container mt-4">
      <div className="card shadow p-4">
        <h4 className="mb-3">🧮 Create Balanced Test</h4>

        {/* ✅ Test Creation Form */}
        <form onSubmit={handleSubmit}>
          <div className="row">
            {/* Test Name */}
            <div className="col-md-4 mb-3">
              <label className="form-label">Test Name</label>
              <input
                name="name"
                className="form-control"
                placeholder="Enter test name"
                value={form.name}
                onChange={handleChange}
                required
              />
            </div>

            {/* Stream */}
            <div className="col-md-4 mb-3">
              <label className="form-label">Stream</label>
              <select
                name="stream_id"
                className="form-select"
                value={form.stream_id}
                onChange={handleChange}
                required
              >
                <option value="">Select Stream</option>
                {streams.map((s) => (
                  <option key={s.id} value={s.id}>
                    {s.name}
                  </option>
                ))}
              </select>
            </div>

            {/* Total Questions */}
            <div className="col-md-4 mb-3">
              <label className="form-label">Total Questions</label>
              <input
                type="number"
                name="totalQuestions"
                className="form-control"
                min="1"
                value={form.totalQuestions}
                onChange={handleChange}
              />
            </div>

            {/* Assign To */}
            <div className="col-md-4 mb-3">
              <label className="form-label">Assign To</label>
              <select
                name="assignTo"
                className="form-select"
                value={form.assignTo}
                onChange={handleChange}
              >
                <option value="stream">Entire Stream</option>
                <option value="student">Specific Student</option>
              </select>
            </div>

            {/* Assign Target */}
            {form.assignTo === "student" && (
              <div className="col-md-4 mb-3">
                <label className="form-label">Select Student</label>
                <select
                  name="assignId"
                  className="form-select"
                  value={form.assignId}
                  onChange={handleChange}
                  required
                >
                  <option value="">Select Student</option>
                  {students.map((st) => (
                    <option key={st.id} value={st.id}>
                      {st.name}
                    </option>
                  ))}
                </select>
              </div>
            )}

            {/* Randomize */}
            <div className="col-md-4 mb-3 d-flex align-items-center">
              <div className="form-check mt-4">
                <input
                  type="checkbox"
                  id="randomize"
                  className="form-check-input"
                  checked={form.randomize}
                  onChange={(e) =>
                    setForm((prev) => ({
                      ...prev,
                      randomize: e.target.checked,
                    }))
                  }
                />
                <label htmlFor="randomize" className="form-check-label">
                  Randomize Questions
                </label>
              </div>
            </div>
          </div>

          <div className="mt-3">
            <button
              type="button"
              className="btn btn-secondary me-2"
              onClick={handlePreview}
              disabled={loading}
            >
              {loading ? "Loading..." : "Preview Distribution"}
            </button>
            <button className="btn btn-primary" disabled={loading}>
              {loading ? "Generating..." : "Generate Test"}
            </button>
          </div>
        </form>

        {/* ✅ Message */}
        {message && <div className="alert alert-info mt-3">{message}</div>}

        {/* ✅ Preview Table */}
        {previewData.length > 0 && (
          <div className="card mt-4 p-3">
            <h5>📊 Question Distribution Preview</h5>
            <div className="table-responsive">
              <table className="table table-bordered table-striped table-sm align-middle">
                <thead>
                  <tr>
                    <th>Subject</th>
                    <th>Category</th>
                    <th>Chapter</th>
                    <th>Easy</th>
                    <th>Medium</th>
                    <th>Hard</th>
                  </tr>
                </thead>
                <tbody>
                  {previewData.map((item, i) => (
                    <tr key={i}>
                      <td>{item.subject}</td>
                      <td>{item.category}</td>
                      <td>{item.chapter}</td>
                      <td>{item.easy}</td>
                      <td>{item.medium}</td>
                      <td>{item.hard}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
