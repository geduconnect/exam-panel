import React, { useState, useEffect } from "react";
import api from "../api";
import { useNavigate } from "react-router-dom";
import { FaBars, FaHome, FaFileAlt, FaUser } from "react-icons/fa";

export default function StudentDashboard() {
  const navigate = useNavigate();

  const [isCollapsed, setIsCollapsed] = useState(false);
  const [streams, setStreams] = useState([]);
  const [selectedStream, setSelectedStream] = useState(null);
  const [subjects, setSubjects] = useState([]);
  const [assignedTest, setAssignedTest] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  // Fetch streams
  useEffect(() => {
    const fetchStreams = async () => {
      try {
        const res = await api.get("/student/streams", { withCredentials: true });
        const data = Array.isArray(res.data) ? res.data : res.data.streams;
        setStreams(data || []);
      } catch (err) {
        setError("Failed to load streams");
      } finally {
        setLoading(false);
      }
    };
    fetchStreams();
  }, []);

  const handleSelectStream = async (stream) => {
    setSelectedStream(stream);
    setSubjects([]);
    setAssignedTest(null);
    setLoading(true);

    try {
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
    } catch {
      setError("Failed to load subjects or test");
    } finally {
      setLoading(false);
    }
  };

  const handleTakeTest = (subjectId) => {
    if (!assignedTest) return alert("No test assigned");
    navigate(`/student/exam/${assignedTest.id}/${subjectId}`);
  };

  return (
    <div className={`dashboard-layout ${isCollapsed ? "collapsed" : ""}`}>

      {/* Sidebar */}
    

      {/* MAIN CONTENT */}
      <main className="student-content">
        <div className="dashboard-box">
          <div className="topbar">
            <h1>Welcome 👋</h1>
          </div>

          {error && <p className="error-msg">{error}</p>}

          {/* STREAMS */}
          {!loading && (
            <div className="streams-section">
              <h2>Select Your Stream</h2>
              <div className="streams-row">
                {streams.length > 0 ? (
                  streams.map((s) => (
                    <div
                      key={s.id}
                      className={`stream-card ${selectedStream?.id === s.id ? "active" : ""
                        }`}
                      onClick={() => handleSelectStream(s)}
                    >
                      <div className="stream-icon">{s.name.charAt(0)}</div>
                      <div>
                        <div className="stream-title">{s.name}</div>
                        <div className="stream-desc">Explore subjects</div>
                      </div>
                    </div>
                  ))
                ) : (
                  <p>No streams available.</p>
                )}
              </div>
            </div>
          )}

          {/* SUBJECTS */}
          {selectedStream && !loading && (
            <div className="subjects-section">
              <h2>{selectedStream.name} Subjects</h2>
              <div className="subjects-grid">
                {subjects.length > 0 ? (
                  subjects.map((sub) => (
                    <div key={sub.id} className="subject-card">
                      <div className="subject-header">
                        <div className="subject-icon">{sub.name.charAt(0)}</div>
                        <div className="subject-title">{sub.name}</div>
                      </div>

                      <button
                        className="primary-btn"
                        onClick={() => handleTakeTest(sub.id)}
                        disabled={!assignedTest}
                      >
                        {assignedTest ? "Take Test" : "No Test Assigned"}
                      </button>
                    </div>
                  ))
                ) : (
                  <p>No subjects found.</p>
                )}
              </div>
            </div>
          )}
        </div>
      </main>
    </div>
  );
}
