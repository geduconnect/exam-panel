import React, { useEffect, useState } from "react";
import api from "../api";
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  Tooltip,
  CartesianGrid,
  ResponsiveContainer,
} from "recharts";

export default function BalancedTestReport({ testId }) {
  const [summary, setSummary] = useState(null);
  const [results, setResults] = useState([]);
  const [loading, setLoading] = useState(true);
  const [exporting, setExporting] = useState(false);
  const [message, setMessage] = useState("");

  useEffect(() => {
    async function fetchData() {
      try {
        const res = await api.get(`/admin/test-summary?test_id=${testId}`);
        setSummary(res.data.summary);
        setResults(res.data.students || []);
      } catch (err) {
        console.error("❌ Error loading report:", err);
        setMessage("Failed to load report. Please try again.");
      } finally {
        setLoading(false);
      }
    }
    fetchData();
  }, [testId]);

  const handleExport = async (type) => {
    try {
      setExporting(true);
      setMessage(`Preparing ${type.toUpperCase()} report...`);
      const url = `${api.defaults.baseURL}/admin/export?test_id=${testId}&type=${type}`;
      window.open(url, "_blank");
      setTimeout(() => {
        setMessage(`✅ ${type.toUpperCase()} exported successfully.`);
        setExporting(false);
      }, 1000);
    } catch (err) {
      console.error("❌ Export failed:", err);
      setMessage(`Failed to export ${type}.`);
      setExporting(false);
    }
  };

  if (loading)
    return (
      <div className="text-center mt-5 fw-bold text-muted">
        Loading report...
      </div>
    );

  if (!summary)
    return (
      <div className="text-center mt-5 text-danger">
        No data available for this test.
      </div>
    );

  const assignedTo =
    summary.assigned_to === "stream"
      ? `Stream — ${summary.assigned_name || "N/A"}`
      : summary.assigned_to === "student"
      ? `Student — ${summary.assigned_name || "N/A"}`
      : "Not Assigned";

  const chartData = results.map((r) => ({
    name: r.student_name,
    percentage: parseFloat(r.percentage || 0),
  }));

  return (
    <div className="report-container">
      <div className="report-card">
        {/* Header */}
        <div className="report-header">
          <h4>📊 Test Summary — {summary.test_name}</h4>
          <span className="badge">ID: {summary.test_id}</span>
        </div>

        {/* Summary */}
        <div className="report-summary">
          <div>
            <strong>Assigned To:</strong> <span>{assignedTo}</span>
          </div>
          <div>
            <strong>Total Students:</strong> {summary.total_attempts}
          </div>
          <div>
            <strong>Average Score:</strong>{" "}
            {Number(summary.avg_percentage).toFixed(2)}%
          </div>
          <div>
            <strong>Highest:</strong>{" "}
            {Number(summary.highest_score).toFixed(2)}%
          </div>
          <div>
            <strong>Lowest:</strong>{" "}
            {Number(summary.lowest_score).toFixed(2)}%
          </div>
        </div>

        {/* Chart */}
        <div className="chart-card mb-4">
          <h6>Student Performance Chart</h6>
          {chartData.length > 0 ? (
            <ResponsiveContainer width="100%" height={300}>
              <BarChart data={chartData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="name" angle={-30} textAnchor="end" height={60} />
                <YAxis domain={[0, 100]} />
                <Tooltip />
                <Bar dataKey="percentage" fill="#3182ce" />
              </BarChart>
            </ResponsiveContainer>
          ) : (
            <p className="text-center text-muted">No chart data available.</p>
          )}
        </div>

        {/* Table */}
        <div className="report-table">
          <h5 className="mt-3 mb-2">🏅 Student Performance</h5>
          <table className="table table-bordered table-sm align-middle">
            <thead className="table-light">
              <tr>
                <th>#</th>
                <th>Student</th>
                <th>Total Marks</th>
                <th>Percentage</th>
                <th>Performance</th>
              </tr>
            </thead>
            <tbody>
              {results.length > 0 ? (
                results.map((r, i) => (
                  <tr key={r.student_id || i}>
                    <td>{i + 1}</td>
                    <td>{r.student_name}</td>
                    <td>{r.total_marks}</td>
                    <td>{r.percentage}%</td>
                    <td>
                      <span
                        className={`badge ${
                          r.performance === "Excellent"
                            ? "bg-success"
                            : r.performance === "Average"
                            ? "bg-warning"
                            : "bg-danger"
                        }`}
                      >
                        {r.performance}
                      </span>
                    </td>
                  </tr>
                ))
              ) : (
                <tr>
                  <td colSpan="5" className="text-center text-muted">
                    No student data available.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>

        {/* Buttons */}
        <div className="report-actions">
          <button
            className="btn btn-outline-primary btn-sm"
            onClick={() => handleExport("pdf")}
            disabled={exporting}
          >
            📄 {exporting ? "Exporting..." : "Export PDF"}
          </button>
          <button
            className="btn btn-outline-success btn-sm"
            onClick={() => handleExport("excel")}
            disabled={exporting}
          >
            📊 {exporting ? "Exporting..." : "Export Excel"}
          </button>
        </div>

        {message && <div className="report-message">{message}</div>}
      </div>
    </div>
  );
}
