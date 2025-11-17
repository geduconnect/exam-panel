// src/pages/admin/AdminTestOverview.jsx
import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import api from "../api";

export default function AdminTestOverview() {
  const [tests, setTests] = useState([]);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    const fetchOverview = async () => {
      try {
        const res = await api.get("/admin/test-overview");
        setTests(res.data.overview || []);
      } catch (err) {
        console.error("❌ Error loading overview:", err);
      } finally {
        setLoading(false);
      }
    };
    fetchOverview();
  }, []);

  if (loading) return <div className="text-center mt-5">Loading...</div>;

  return (
    <div className="container mt-4">
      <div className="card shadow p-4">
        <h4 className="mb-3">📊 All Tests Overview</h4>
        {tests.length === 0 ? (
          <p className="text-center text-muted">No tests found.</p>
        ) : (
          <div className="table-responsive">
            <table className="table table-striped align-middle">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Test Name</th>
                  <th>Stream</th>
                  <th>Total Attempts</th>
                  <th>Average %</th>
                  <th>Highest %</th>
                  <th>Lowest %</th>
                  <th>Top Student</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
                {tests.map((t, i) => (
                  <tr key={t.test_id}>
                    <td>{i + 1}</td>
                    <td>{t.test_name}</td>
                    <td>{t.stream_name}</td>
                    <td>{t.total_attempts}</td>
                    <td>{Number(t.avg_percentage).toFixed(2)}%</td>
                    <td>{Number(t.highest_percentage).toFixed(2)}%</td>
                    <td>{Number(t.lowest_percentage).toFixed(2)}%</td>
                    <td>{t.best_student || "—"}</td>
                    <td>
                      <button
                        className="btn btn-sm btn-outline-primary"
                       onClick={() => navigate(`/admin/test-summary/${t.test_id}`)}
                      >
                        🔍 View Summary
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  );
}
