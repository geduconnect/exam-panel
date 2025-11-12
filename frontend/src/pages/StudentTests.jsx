import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import api from "../api";

export default function StudentTests() {
  const [tests, setTests] = useState([]);
  const [loading, setLoading] = useState(true);
  const [message, setMessage] = useState("");
  const navigate = useNavigate();

  useEffect(() => {
    async function fetchTests() {
      try {
        const res = await api.get("/student/tests/assigned", {
          withCredentials: true,
        });
        setTests(res.data.tests || []);
      } catch (err) {
        console.error("Error loading assigned tests:", err);
        setMessage("❌ Failed to load tests.");
      } finally {
        setLoading(false);
      }
    }
    fetchTests();
  }, []);

  // 🌀 Loading screen
  if (loading)
    return (
      <div className="test-loader">
        <div className="spinner"></div>
        <p>Loading your tests...</p>
      </div>
    );

  // 📭 Empty state
  if (tests.length === 0)
    return (
      <div className="no-tests">
        <h3>📘 No Tests Assigned Yet</h3>
        <p>Your assigned tests will appear here when available.</p>
      </div>
    );

  // ✅ Main UI
  return (
    <div className="test-container mt-4">
      <h4>🧠 My Available Tests</h4>
      {message && <div className="alert alert-info mt-3">{message}</div>}

      <div className="card mt-3 p-3 table-responsive">
        <table className="table table-bordered table-striped table-sm">
          <thead>
            <tr>
              <th>#</th>
              <th>Test Name</th>
              <th>Stream</th>
              <th>Total Questions</th>
              <th>Randomized</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            {tests.map((t, i) => (
              <tr key={t.id}>
                <td>{i + 1}</td>
                <td>{t.name}</td>
                <td>{t.stream_name}</td>
                <td>{t.total_questions}</td>
                <td>{t.randomize ? "Yes" : "No"}</td>
                <td>
                  <button
                    className="btn btn-primary btn-sm"
                    onClick={() => navigate(`/student/test/${t.id}`)}
                  >
                    Start Test →
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
