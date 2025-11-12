import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import api from "../api";

export default function StudentReport() {
  const { testId } = useParams();
  const navigate = useNavigate();
  const [overview, setOverview] = useState(null);
  const [subjectWise, setSubjectWise] = useState([]);
  const [chapterWise, setChapterWise] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    const fetchReport = async () => {
      try {
        const res = await api.get(`/student/test-report?test_id=${testId}`, {
          withCredentials: true,
        });
        setOverview(res.data.overview);
        setSubjectWise(res.data.subjectwise || []);
        setChapterWise(res.data.chapterwise || []);
      } catch (err) {
        console.error("❌ Error loading report:", err);
        setError(err?.response?.data?.error || "Failed to load report.");
      } finally {
        setLoading(false);
      }
    };
    fetchReport();
  }, [testId]);

  const formatDate = (date) => {
    try {
      return new Date(date).toLocaleString();
    } catch {
      return date;
    }
  };

  if (loading) return <p>Loading detailed report...</p>;
  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (!overview) return <p>No report data found for this test.</p>;

  return (
    <div className="report-container">


      <h1 className="report-title">{overview.test_name} - Report</h1>

      {/* ✅ Overall Summary */}
      <div className="overview-box">
        <div className="overview-item">
          <h3>Score</h3>
          <p>
            {overview.score}/{overview.total_questions}
          </p>
        </div>
        <div className="overview-item">
          <h3>Percentage</h3>
          <p>{overview.percentage}%</p>
        </div>
        <div className="overview-item">
          <h3>Date</h3>
          <p>{new Date(overview.date).toLocaleDateString()}</p>
        </div>
        <div className="overview-item">
          {overview.rank && (
            <p>
              <strong>Rank:</strong> #{overview.rank}
            </p>
          )}
        </div>
      </div>

      <div className="subject-section">
        <h2>Subject Wise Performance</h2>
        <table className="subject-table">
          <thead>
            <tr>
              <th>Subject</th>
              <th>Total</th>
              <th>Correct</th>
              <th>Accuracy</th>
            </tr>
          </thead>
          <tbody>
            {subjectWise.length === 0 ? (
              <tr>
                <td colSpan="4">No data available.</td>
              </tr>
            ) : (
              subjectWise.map((s, i) => (
                <tr key={i}>
                  <td>{s.subject_name || "N/A"}</td>
                  <td>{s.total}</td>
                  <td>{s.correct}</td>
                  <td>
                    <div className="accuracy-cell">
                      <span>{s.accuracy}%</span>
                      <div
                        className="accuracy-bar"
                        style={{
                          width: `${s.accuracy}%`,
                          backgroundColor:
                            s.accuracy >= 80
                              ? "#4CAF50"
                              : s.accuracy >= 50
                                ? "#FFC107"
                                : "#F44336",
                        }}
                      ></div>
                    </div>
                  </td>
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>

      <div className="subject-section">
        <h2>Chapter Wise Performance</h2>
        <h3 style={{ marginTop: "30px" }}>📗 Chapter-wise Analysis</h3>
        <table className="report-table">
          <thead>
            <tr>
              <th>Chapter</th>
              <th>Subject</th>
              <th>Total</th>
              <th>Correct</th>
              <th>Accuracy</th>
            </tr>
          </thead>
          <tbody>
            {chapterWise.length === 0 ? (
              <tr>
                <td colSpan="5">No data available.</td>
              </tr>
            ) : (
              chapterWise.map((c, i) => (
                <tr key={i}>
                  <td>{c.chapter_name || "N/A"}</td>
                  <td>{c.subject_name || "N/A"}</td>
                  <td>{c.total}</td>
                  <td>{c.correct}</td>
                  <td>
                    <div className="accuracy-cell">
                      <span>{c.accuracy}%</span>
                      <div
                        className="accuracy-bar"
                        style={{
                          width: `${c.accuracy}%`,
                          backgroundColor:
                            c.accuracy >= 80
                              ? "#4CAF50"
                              : c.accuracy >= 50
                                ? "#FFC107"
                                : "#F44336",
                        }}
                      ></div>
                    </div>
                  </td>
                </tr>
              ))
            )}
          </tbody>
        </table>

        <button
          className="btn-back"
          onClick={() => navigate("/student/reports")}
          style={{ marginTop: "20px" }}
        >
          ← Back to Reports
        </button>
      </div>
    </div>
  );
}
