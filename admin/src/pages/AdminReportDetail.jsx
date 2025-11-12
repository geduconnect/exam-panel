import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import api from "../api";

export default function AdminReportDetail() {
  const { studentId, testId } = useParams();
  const navigate = useNavigate();
  const [overview, setOverview] = useState(null);
  const [subjectWise, setSubjectWise] = useState([]);
  const [chapterWise, setChapterWise] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const load = async () => {
      try {
        const res = await api.get(
          `/admin/reports/report?student_id=${studentId}&test_id=${testId}`
        );
        setOverview(res.data.overview);
        setSubjectWise(res.data.subjectwise || []);
        setChapterWise(res.data.chapterwise || []);
      } catch (err) {
        console.error("❌ Error loading admin report:", err);
      } finally {
        setLoading(false);
      }
    };
    load();
  }, [studentId, testId]);

  if (loading) return <p>Loading detailed report...</p>;
  if (!overview) return <p>No report found.</p>;

  return (
    <div className="report-container">
      <h1>{overview.test_name} - {overview.student_name}</h1>

      <div className="overview-box">
        <div>Score: {overview.score}/{overview.total_questions}</div>
        <div>Percentage: {overview.percentage}%</div>
        <div>Date: {new Date(overview.date).toLocaleString()}</div>
      </div>

      <h2>Subject Wise</h2>
      <table className="report-table">
        <thead>
          <tr><th>Subject</th><th>Total</th><th>Correct</th><th>Accuracy</th></tr>
        </thead>
        <tbody>
          {subjectWise.map((s, i) => (
            <tr key={i}>
              <td>{s.subject_name}</td>
              <td>{s.total}</td>
              <td>{s.correct}</td>
              <td>{s.accuracy}%</td>
            </tr>
          ))}
        </tbody>
      </table>

      <h2>Chapter Wise</h2>
      <table className="report-table">
        <thead>
          <tr><th>Chapter</th><th>Subject</th><th>Total</th><th>Correct</th><th>Accuracy</th></tr>
        </thead>
        <tbody>
          {chapterWise.map((c, i) => (
            <tr key={i}>
              <td>{c.chapter_name}</td>
              <td>{c.subject_name}</td>
              <td>{c.total}</td>
              <td>{c.correct}</td>
              <td>{c.accuracy}%</td>
            </tr>
          ))}
        </tbody>
      </table>

      <button className="btn-back" onClick={() => navigate("/admin/reports")}>
        ← Back to Reports
      </button>
    </div>
  );
}
