import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import api from "../api";

export default function AdminReportsList() {
  const [reports, setReports] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const load = async () => {
      try {
        const res = await api.get("/admin/reports/results");
        setReports(res.data.results || []);
      } catch (err) {
        console.error("❌ Load admin reports error:", err);
      } finally {
        setLoading(false);
      }
    };
    load();
  }, []);

  if (loading) return <p>Loading reports...</p>;

  return (
    <div className="admin-container">
      <h1>📊 Student Test Reports</h1>

      {reports.length === 0 ? (
        <p>No reports found.</p>
      ) : (
        <table className="report-table">
          <thead>
            <tr>
              <th>#</th>
              <th>Student</th>
              <th>Email</th>
              <th>Stream</th>
              <th>Test</th>
              <th>Subject</th>
              <th>Score</th>
              <th>Total</th>
              <th>%</th>
              <th>Date</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            {reports.map((r, i) => (
              <tr key={r.id}>
                <td>{i + 1}</td>
                <td>{r.student_name}</td>
                <td>{r.email}</td>
                <td>{r.stream_name}</td>
                <td>{r.test_name}</td>
                <td>{r.subject_name || "-"}</td>
                <td>{r.score}</td>
                <td>{r.total_questions}</td>
                <td>{r.percentage}%</td>
                <td>{new Date(r.date).toLocaleDateString()}</td>
                <td>
                  <Link
                    to={`/admin/report/${r.student_id}/${r.test_id}`}
                    className="view-link"
                  >
                    View
                  </Link>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}
