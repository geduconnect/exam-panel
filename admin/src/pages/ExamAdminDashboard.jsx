import React, { useEffect, useState, useRef } from "react";

const API_BASE = import.meta.env.VITE_API_BASE_URL || "/api";

export default function ExamAdminDashboard() {
  const [stats, setStats] = useState({});
  const [questions, setQuestions] = useState([]);
  const [reports, setReports] = useState([]);
  const [sessions, setSessions] = useState([]);
  const [testName, setTestName] = useState("");
  const [stream, setStream] = useState("");
  const pollingRef = useRef(null);

  // Fetch overview stats
  useEffect(() => {
    fetchStats();
    fetchQuestions();
    fetchReports();
    fetchSessions();
    pollingRef.current = setInterval(fetchSessions, 5000);
    return () => clearInterval(pollingRef.current);
  }, []);

  async function fetchStats() {
    try {
      const res = await fetch(`${API_BASE}/admin/overview`);
      const data = await res.json();
      setStats(data || {});
    } catch (err) {
      console.error("Stats fetch error:", err);
    }
  }

  async function fetchQuestions() {
    try {
      const res = await fetch(`${API_BASE}/questions`);
      const data = await res.json();
      setQuestions(data || []);
    } catch (err) {
      console.error("Questions fetch error:", err);
    }
  }

  async function fetchReports() {
    try {
      const res = await fetch(`${API_BASE}/reports`);
      const data = await res.json();
      setReports(data || []);
    } catch (err) {
      console.error("Reports fetch error:", err);
    }
  }

  async function fetchSessions() {
    try {
      const res = await fetch(`${API_BASE}/live-sessions`);
      const data = await res.json();
      setSessions(data || []);
    } catch (err) {
      console.error("Sessions fetch error:", err);
    }
  }

  async function createTest(e) {
    e.preventDefault();
    try {
      const res = await fetch(`${API_BASE}/tests`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          name: testName,
          stream,
          total_duration: 90,
          per_subject_duration: 30,
          time_per_question: 20,
          distribution: { equalAcrossSubjects: true },
        }),
      });
      const data = await res.json();
      alert("✅ Test created successfully!");
      setTestName("");
      setStream("");
      fetchStats();
    } catch (err) {
      alert("❌ Failed to create test");
      console.error(err);
    }
  }

  return (
    <div className="min-h-screen p-6 bg-slate-50">
      <div className="max-w-7xl mx-auto">
        <header className="mb-6 flex items-center justify-between">
          <h1 className="text-2xl font-bold">Examination Panel — Admin Dashboard</h1>
          <div className="flex items-center gap-3">
            <button className="btn">Create Test</button>
            <button className="btn">Manage Questions</button>
            <button className="btn-ghost">Settings</button>
          </div>
        </header>

        {/* Overview Cards */}
        <div className="grid-cards fade-in mb-6">
          {[
            { label: "Total Tests", value: stats.totalTests },
            { label: "Active Sessions", value: stats.activeSessions },
            { label: "Registered Students", value: stats.students },
            { label: "Completed Tests", value: stats.completed },
          ].map((item) => (
            <div key={item.label} className="card card-hover">
              <div className="text-muted text-sm">{item.label}</div>
              <div className="mt-1 text-2xl font-semibold">{item.value ?? 0}</div>
            </div>
          ))}
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-4 mb-6">
          {/* Left section: Question Bank + Reports */}
          <div className="lg:col-span-2 space-y-4">
            {/* Question Bank */}
            <div className="card fade-in">
              
              <div className="overflow-x-auto">
                <table>
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Subject</th>
                      <th>Category</th>
                      <th>Chapter</th>
                      <th>Sub-Category</th>
                      <th>Difficulty</th>
                      <th>Marks</th>
                    </tr>
                  </thead>
                  <tbody>
                    {questions.length === 0 ? (
                      <tr><td colSpan={7}>No questions found.</td></tr>
                    ) : (
                      questions.map((q) => (
                        <tr key={q.question_id}>
                          <td>{q.question_id}</td>
                          <td>{q.subject_name}</td>
                          <td>{q.category_name}</td>
                          <td>{q.chapter_name}</td>
                          <td>{q.subcategory_name}</td>
                          <td>{q.difficulty}</td>
                          <td>{q.marks ?? 1}</td>
                        </tr>
                      ))
                    )}
                  </tbody>
                </table>
              </div>
            </div>

            {/* Reports */}
         
          </div>

          {/* Right section: Test Creation + Live Monitor */}
          
        </div>

        <footer className="text-sm text-slate-500">
          Built for: Examination Panel — Subject → Category → Chapter → Sub-Category hierarchy.
        </footer>
      </div>
    </div>
  );
}
