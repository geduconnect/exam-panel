import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import api from "../api";

export default function BalancedTestList() {
  const [tests, setTests] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const navigate = useNavigate();

  useEffect(() => {
    const fetchTests = async () => {
      try {
        const res = await api.get("/admin/tests/list");
        setTests(res.data.tests || []);
      } catch (err) {
        console.error("❌ Error fetching tests:", err);
        setError("Failed to load test list. Please try again later.");
      } finally {
        setLoading(false);
      }
    };
    fetchTests();
  }, []);

  if (loading)
    return (
      <div className="text-center mt-5 fw-bold text-muted">
        Loading tests...
      </div>
    );

  if (error)
    return <div className="alert alert-danger text-center mt-4">{error}</div>;

  return (
    <div className="container mt-4">
      <div className="card shadow p-4">
        <h4 className="mb-3">📚 Balanced Tests</h4>

        {tests.length === 0 ? (
          <div className="text-center text-muted">
            No balanced tests available.
          </div>
        ) : (
          <div className="table-responsive">
            <table className="table table-bordered table-striped align-middle">
              <thead className="table-light">
                <tr>
                  <th>#</th>
                  <th>Test Name</th>
                  <th>Stream</th>
                  <th>Subject</th>
                  <th>Created On</th>
                  <th>Total Questions</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                {tests.map((test, index) => (
                  <tr key={test.id || index}>
                    <td>{index + 1}</td>
                    <td>{test.name}</td>
                    <td>{test.stream_name || "—"}</td>
                    <td>{test.subject_name || "—"}</td>
                    <td>{new Date(test.created_at).toLocaleDateString()}</td>
                    <td>{test.total_questions || 0}</td>
                    <td>
                      <div className="d-flex gap-2">
                        <button
                          className="btn btn-sm btn-outline-primary"
                          onClick={() => navigate(`/balancedtests/${test.id}/view`)}
                        >
                          🔍 View
                        </button>
                        <button
                          className="btn btn-sm btn-outline-success"
                          onClick={() =>
                            navigate(`/balancedtests/report/${test.id}`)
                          }
                        >
                          📊 View Report
                        </button>
                      </div>
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
