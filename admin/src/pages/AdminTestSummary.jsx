import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import api from "../api";

export default function AdminTestSummary() {
  const { test_id } = useParams();
  const navigate = useNavigate();
  const [report, setReport] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const load = async () => {
      try {
       const res = await api.get(`/admin/reports/test/${test_id}`);
        setReport(res.data);
      } catch (err) {
        console.error("❌ Error loading test report:", err);
      } finally {
        setLoading(false);
      }
    };
    load();
  }, [test_id]);

  if (loading) return <p className="text-center mt-5">Loading report...</p>;
  if (!report) return <p className="text-center mt-5">No report found.</p>;

  const { test, summary, students, subject_stats, chapter_stats } = report;

  return (
    <div className="container mt-4">
      <div className="card shadow p-4">
        <button
          className="btn btn-sm btn-outline-secondary mb-3"
          onClick={() => navigate(-1)}
        >
          ← Back
        </button>

        <h3 className="mb-3">{test.name}</h3>
        <p className="text-muted">
          Stream: {test.stream_name} | Total Questions: {test.total_questions}
        </p>

        <div className="mb-3">
          <strong>Total Students:</strong> {summary.total_students} <br />
          <strong>Average Percentage:</strong> {summary.average_percentage}%
        </div>

        {/* 🧑‍🎓 Student Rankings */}
        <h5 className="mt-4">🏆 Student Rankings</h5>
        <div className="table-responsive">
          <table className="table table-striped align-middle">
            <thead>
              <tr>
                <th>Rank</th>
                <th>Student</th>
                <th>Correct</th>
                <th>Attempted</th>
                <th>Percentage</th>
                <th>Time Taken (min)</th>
              </tr>
            </thead>
            <tbody>
              {students.map((s) => (
                <tr key={s.student_id}>
                  <td>{s.rank}</td>
                  <td>{s.student_name}</td>
                  <td>{s.correct}</td>
                  <td>{s.attempted}</td>
                  <td>{s.percentage}%</td>
                  <td>{s.time_taken}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        {/* 📚 Subject-wise stats */}
        <h5 className="mt-4">📚 Subject Performance</h5>
        <table className="table table-bordered align-middle">
          <thead>
            <tr>
              <th>Subject</th>
              <th>Total Questions</th>
              <th>Correct</th>
              <th>Avg Accuracy</th>
            </tr>
          </thead>
          <tbody>
            {subject_stats.map((s, i) => (
              <tr key={i}>
                <td>{s.subject_name}</td>
                <td>{s.total_questions}</td>
                <td>{s.total_correct}</td>
                <td>{s.avg_accuracy}%</td>
              </tr>
            ))}
          </tbody>
        </table>

        {/* 📘 Chapter-wise stats */}
        <h5 className="mt-4">📘 Chapter Performance</h5>
        <table className="table table-bordered align-middle">
          <thead>
            <tr>
              <th>Subject</th>
              <th>Chapter</th>
              <th>Total Questions</th>
              <th>Correct</th>
              <th>Avg Accuracy</th>
            </tr>
          </thead>
          <tbody>
            {chapter_stats.map((c, i) => (
              <tr key={i}>
                <td>{c.subject_name}</td>
                <td>{c.chapter_name}</td>
                <td>{c.total_questions}</td>
                <td>{c.total_correct}</td>
                <td>{c.avg_accuracy}%</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
