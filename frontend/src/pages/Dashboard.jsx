import React, { useState, useEffect } from "react";
import api from "../api";
import { useNavigate } from "react-router-dom";

export default function StudentDashboard() {
  const navigate = useNavigate();

  const [streams, setStreams] = useState([]);
  const [selectedStream, setSelectedStream] = useState(null);
  const [subjects, setSubjects] = useState([]);
  const [assignedTest, setAssignedTest] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  // ✅ Fetch student's streams
  useEffect(() => {
    const fetchStreams = async () => {
      try {
        const res = await api.get("/student/streams", { withCredentials: true });
        const data = Array.isArray(res.data) ? res.data : res.data.streams;
        setStreams(data || []);
      } catch (err) {
        console.error(err);
        setError("Failed to load streams");
      } finally {
        setLoading(false);
      }
    };
    fetchStreams();
  }, []);

  // ✅ When stream selected → fetch subjects from backend
  const handleSelectStream = async (stream) => {
    setSelectedStream(stream);
    setSubjects([]);
    setAssignedTest(null);
    setLoading(true);

    try {
      // 🔹 New API: get test + subjects from backend in one go
      const res = await api.get(`/student/tests/subjects/${stream.id}`, {
        withCredentials: true,
      });

      if (res.data) {
        setAssignedTest({
          id: res.data.test_id,
          name: res.data.test_name,
        });
        setSubjects(res.data.subjects || []);
      }
    } catch (err) {
      console.error(err);
      setError("Failed to load subjects or test");
    } finally {
      setLoading(false);
    }
  };

  // ✅ When a subject is selected → open StudentExamPage
  const handleTakeTest = (subjectId) => {
    if (!assignedTest) {
      alert("No test assigned for this stream yet.");
      return;
    }
    navigate(`/student/exam/${assignedTest.id}/${subjectId}`);
  };

  return (
    <div className="dashboard-layout">
      {/* Sidebar */}
      <aside className="sidebar">
        <div className="brand">🎓 GQUEST</div>
        <div className="menu">
          <button className="active">Dashboard</button>
          <button onClick={() => navigate("/student/reports")}>Reports</button>
          <button onClick={() => navigate("/profile")}>Profile</button>
        </div>
      </aside>

      {/* Main Content */}
      <main className="content">
        <div className="topbar">
          <h1>Welcome 👋</h1>
        </div>

        {error && <p className="error-msg">{error}</p>}

        {/* Stream Selection */}
        {loading ? (
          <p>Loading...</p>
        ) : (
          <div className="card selector-card">
            <h2>Select Your Stream</h2>
            <div className="streams-grid">
              {streams.length > 0 ? (
                streams.map((s) => (
                  <div
                    key={s.id}
                    className={`stream-card ${
                      selectedStream?.id === s.id ? "active" : ""
                    }`}
                    onClick={() => handleSelectStream(s)}
                  >
                    <div className="stream-icon">{s.name.charAt(0)}</div>
                    <div className="stream-body">
                      <div className="stream-title">{s.name}</div>
                      <div className="stream-desc">
                        Explore courses & subjects
                      </div>
                    </div>
                  </div>
                ))
              ) : (
                <p>No streams available.</p>
              )}
            </div>
          </div>
        )}

        {/* Subject Selection */}
        {selectedStream && !loading && (
          <div className="subjects-section">
            <h2>{selectedStream.name} Subjects</h2>
            <div className="subjects-grid">
              {subjects.length > 0 ? (
                subjects.map((sub) => (
                  <div key={sub.id} className="subject-card">
                    <div className="subject-header">
                      <div className="subject-icon">{sub.name.charAt(0)}</div>
                      <div>
                        <div className="subject-title">{sub.name}</div>
                      </div>
                    </div>
                    <div className="actions">
                      <button
                        className="primary-btn"
                        onClick={() => handleTakeTest(sub.id)}
                        disabled={!assignedTest}
                      >
                        {assignedTest ? "Take Test" : "No Test Assigned"}
                      </button>
                    </div>
                  </div>
                ))
              ) : (
                <p>No subjects found for this stream.</p>
              )}
            </div>
          </div>
        )}
      </main>
    </div>
  );
}
