import React, { useState, useEffect } from "react";
import api from "../api";

export default function AdminTestCreator() {
  const [streams, setStreams] = useState([]);
  const [form, setForm] = useState({
    name: "",
    stream_id: "",
    total_questions: 100,
    duration: 90,
    randomize: true,
    assigned_to: "batch",
    assigned_id: "",
  });
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState("");

  useEffect(() => {
    api.get("/admin/streams").then((res) => setStreams(res.data));
  }, []);

  const handleChange = (e) =>
    setForm({ ...form, [e.target.name]: e.target.value });

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setMessage("");
    try {
      const res = await api.post("/tests/create", form);
      setMessage(`✅ Test created successfully (ID: ${res.data.test_id})`);
    } catch (err) {
      setMessage("❌ Failed to create test: " + err.response?.data?.error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="container mt-4">
      <h4>Create New Test</h4>
      <form onSubmit={handleSubmit} className="card p-3 mt-3">
        <div className="row">
          <div className="col-md-4 mb-3">
            <label>Test Name</label>
            <input
              type="text"
              name="name"
              className="form-control"
              value={form.name}
              onChange={handleChange}
              required
            />
          </div>

          <div className="col-md-4 mb-3">
            <label>Stream</label>
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

          <div className="col-md-4 mb-3">
            <label>Total Questions</label>
            <input
              type="number"
              name="total_questions"
              className="form-control"
              value={form.total_questions}
              onChange={handleChange}
            />
          </div>

          <div className="col-md-4 mb-3">
            <label>Duration (minutes)</label>
            <input
              type="number"
              name="duration"
              className="form-control"
              value={form.duration}
              onChange={handleChange}
            />
          </div>

          <div className="col-md-4 mb-3">
            <label>Assign To</label>
            <select
              name="assigned_to"
              className="form-select"
              value={form.assigned_to}
              onChange={handleChange}
            >
              <option value="batch">Batch</option>
              <option value="stream">Stream</option>
              <option value="student">Student</option>
            </select>
          </div>

          <div className="col-md-4 mb-3">
            <label>Assign ID</label>
            <input
              type="text"
              name="assigned_id"
              className="form-control"
              value={form.assigned_id}
              onChange={handleChange}
              placeholder="Enter Batch/Stream/Student ID"
            />
          </div>

          <div className="col-md-4 mb-3 form-check">
            <input
              type="checkbox"
              className="form-check-input"
              id="randomize"
              name="randomize"
              checked={form.randomize}
              onChange={(e) =>
                setForm({ ...form, randomize: e.target.checked })
              }
            />
            <label htmlFor="randomize" className="form-check-label">
              Randomize Questions
            </label>
          </div>
        </div>

        <button className="btn btn-primary" disabled={loading}>
          {loading ? "Generating..." : "Create Test"}
        </button>
      </form>

      {message && <div className="alert alert-info mt-3">{message}</div>}
    </div>
  );
}
