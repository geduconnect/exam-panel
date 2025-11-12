import React, { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import api from "../api";

export default function StudentReportsView() {
  const [results, setResults] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const navigate = useNavigate();

  useEffect(() => {
    const fetchReports = async () => {
      try {
        const res = await api.get("/student/results", { withCredentials: true });
        setResults(res.data.results || []);
      } catch (err) {
        console.error("❌ Error fetching reports:", err);
        setError(err?.response?.data?.error || "Failed to load reports.");
      } finally {
        setLoading(false);
      }
    };
    fetchReports();
  }, []);

  const formatDate = (date) => {
    try {
      return new Date(date).toLocaleString();
    } catch {
      return date;
    }
  };

  if (loading) return <p>Loading reports...</p>;
  if (error) return <p style={{ color: "red" }}>{error}</p>;

  return (
    <div className="student-container">
      <aside className="question-sidebar">
        <h2>📊 Reports</h2>
        <button onClick={() => navigate("/student/dashboard")}>Dashboard</button>
        <button onClick={() => navigate("/student/tests")}>Tests</button>
      </aside>

      <main className="student-main">
        <h1>My Reports</h1>

        {results.length === 0 ? (
          <p>No reports found.</p>
        ) : (
          <table className="report-table">
            <thead>
              <tr>
                <th>#</th>
                <th>Test Name</th>
                <th>Subject</th>
                <th>Score</th>
                <th>Total</th>
                <th>Percentage</th>
                <th>Date</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              {results.map((r, i) => (
                <tr key={i}>
                  <td>{i + 1}</td>
                  <td>{r.test_name}</td>
                  <td>{r.subject_name || "-"}</td>
                  <td>{r.score}</td>
                  <td>{r.total_questions}</td>
                  <td>{r.percentage}%</td>
                  <td>{formatDate(r.created_at)}</td>
                  <td>
                    <Link to={`/student/report/${r.test_id}`} className="view-link">
                      View Report
                    </Link>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </main>
    </div>
  );
}
