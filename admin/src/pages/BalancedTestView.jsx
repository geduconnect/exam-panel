import React, { useEffect, useState } from "react";
import { useParams, Link, useNavigate } from "react-router-dom";
import api from "../api";

export default function BalancedTestView() {
  const { id } = useParams();
  const [questions, setQuestions] = useState([]);
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState("");
  const navigate = useNavigate();

  useEffect(() => {
    fetchQuestions();
  }, [id]);

  const fetchQuestions = async () => {
    setLoading(true);
    try {
      const res = await api.get(`/admin/tests/${id}/questions`);
      setQuestions(res.data.questions || []);
    } catch (err) {
      console.error("❌ Error loading questions:", err);
      setMessage("❌ Unable to load questions for this test.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="container mt-4">
      <div className="d-flex justify-content-between align-items-center">
        <h4>🧩 Test #{id} — Questions</h4>
        <div className="d-flex gap-2">
          <Link to="/balancedtestslist" className="btn btn-secondary btn-sm">
            ← Back to Tests
          </Link>
          <button
            className="btn btn-success btn-sm"
            onClick={() => navigate(`/balancedtests/report/${id}`)}
          >
            📊 View Report
          </button>
        </div>
      </div>

      {message && <div className="alert alert-info mt-3">{message}</div>}

      {loading ? (
        <div className="text-center mt-4">Loading...</div>
      ) : questions.length === 0 ? (
        <div className="alert alert-warning mt-3">No questions found.</div>
      ) : (
        <div className="card mt-3 p-3 table-responsive">
          <table className="table table-bordered table-striped table-sm">
            <thead>
              <tr>
                <th>#</th>
                <th>Question</th>
                <th>Options</th>
                <th>Answer</th>
                <th>Level</th>
                <th>Subject</th>
                <th>Category</th>
                <th>Chapter</th>
              </tr>
            </thead>
            <tbody>
              {questions.map((q, i) => (
                <tr key={q.id}>
                  <td>{i + 1}</td>
                  <td>{q.question}</td>
                  <td>
                    <div><b>A:</b> {q.option_a}</div>
                    <div><b>B:</b> {q.option_b}</div>
                    <div><b>C:</b> {q.option_c}</div>
                    <div><b>D:</b> {q.option_d}</div>
                  </td>
                  <td className="fw-bold text-success">{q.answer}</td>
                  <td>{q.level}</td>
                  <td>{q.subject_name}</td>
                  <td>{q.category_name}</td>
                  <td>{q.chapter_name}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}
