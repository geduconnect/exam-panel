import React, { useEffect, useState } from "react";
import { useParams, Link } from "react-router-dom";
import api from "../api";

export default function BalancedTestReport() {
  const { id } = useParams(); // test_id
  const [report, setReport] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    const fetchReport = async () => {
      setLoading(true);
      try {
        const res = await api.get(`/admin/reports/test/${id}`);
        setReport(res.data);
      } catch (err) {
        console.error("❌ Error fetching report:", err);
        setError("Failed to load test report.");
      } finally {
        setLoading(false);
      }
    };
    fetchReport();
  }, [id]);

  if (loading)
    return (
      <div className="text-center mt-5 fw-bold text-muted">Loading report...</div>
    );

  if (error)
    return (
      <div className="alert alert-danger text-center mt-4">
        ❌ {error}
      </div>
    );

  if (!report)
    return (
      <div className="alert alert-warning text-center mt-4">
        No report data found.
      </div>
    );

  const { test, students } = report;

  return (
    <div className="container mt-4">
      <div className="d-flex justify-content-between align-items-center mb-3">
        <h4>
          📊 Report — {test.name}{" "}
          <small className="text-muted">({test.stream_name || "No stream"})</small>
        </h4>
        <Link to="/balancedtestslist" className="btn btn-secondary btn-sm">
          ← Back to Tests
        </Link>
      </div>

      <div className="card shadow p-3">
        <div className="mb-3">
          <strong>Total Questions:</strong> {test.total_questions}
        </div>

        {students.length === 0 ? (
          <div className="text-center text-muted">No students attempted this test yet.</div>
        ) : (
          <div className="table-responsive">
            <table className="table table-bordered table-striped align-middle">
              <thead className="table-light">
                <tr>
                  <th>Rank 🏅</th>
                  <th>Student Name</th>
                  <th>Attempted</th>
                  <th>Correct</th>
                  <th>Score (%)</th>
                  <th>Time Taken (min)</th>
                </tr>
              </thead>
              <tbody>
                {students.map((s, index) => (
                  <tr key={s.student_id || index}>
                    <td className="fw-bold">{s.rank}</td>
                    <td>{s.student_name}</td>
                    <td>{s.attempted}</td>
                    <td className="text-success fw-semibold">{s.correct}</td>
                    <td>{s.percentage}%</td>
                    <td>{s.time_taken ? `${s.time_taken}` : "—"}</td>
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
