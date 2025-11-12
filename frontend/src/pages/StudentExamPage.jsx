// StudentExamPage.jsx
import React, { useEffect, useState, useRef } from "react";
import { useParams, useNavigate } from "react-router-dom";
import api from "../api";
import { useStudent } from "../context/StudentContext";

export default function StudentExamPage() {
  const { testId, subjectId } = useParams();
  const navigate = useNavigate();
  const { student } = useStudent();

  const [started, setStarted] = useState(false);
  const [questions, setQuestions] = useState([]);
  const [answers, setAnswers] = useState({});
  const [marked, setMarked] = useState([]);
  const [current, setCurrent] = useState(0);
  const [timeLeft, setTimeLeft] = useState(1200);
  const [submitted, setSubmitted] = useState(false);
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [toast, setToast] = useState("");
  const violationCount = useRef(0);
  const autoSaveTimer = useRef(null);

  // ---- Fullscreen helpers ----
  const enterFullScreen = async () => {
    const el = document.documentElement;
    try {
      if (el.requestFullscreen) await el.requestFullscreen();
      else if (el.mozRequestFullScreen) await el.mozRequestFullScreen();
      else if (el.webkitRequestFullscreen) await el.webkitRequestFullscreen();
      else if (el.msRequestFullScreen) await el.msRequestFullScreen();
    } catch (e) {
      console.warn("enterFullScreen failed:", e);
    }
  };

  const forceFullScreen = () => {
    if (!document.fullscreenElement) enterFullScreen();
  };

  const exitFullScreen = async () => {
    try {
      if (document.exitFullscreen) await document.exitFullscreen();
    } catch {}
  };

  // ---- Load questions ----
  useEffect(() => {
    (async () => {
      try {
        const res = await api.get(
          `/student/tests/${testId}/questions?subject_id=${subjectId}`,
          { withCredentials: true }
        );
        const data = res.data;
        setQuestions(data.questions || []);
        if (data.savedAnswers) setAnswers(data.savedAnswers);
      } catch (err) {
        console.error("Error loading questions:", err);
      } finally {
        setLoading(false);
      }
    })();
  }, [testId, subjectId]);

  // ---- Start test ----
  const handleStartTest = async () => {
    await api
      .post(
        `/student/tests/${testId}/start?subject_id=${subjectId}`,
        {},
        { withCredentials: true }
      )
      .catch(() => {});
    await enterFullScreen();
    setStarted(true);
  };

  // ---- Timer ----
  useEffect(() => {
    if (submitted) return;
    const t = setInterval(() => setTimeLeft((t) => (t > 0 ? t - 1 : 0)), 1000);
    return () => clearInterval(t);
  }, [submitted]);

  useEffect(() => {
    if (timeLeft === 0 && !submitted) handleSubmit("time-up");
  }, [timeLeft]);

  // ---- Auto-save ----
  useEffect(() => {
    if (submitted) return;
    autoSaveTimer.current = setInterval(() => {
      api
        .post(
          `/student/tests/${testId}/save?subject_id=${subjectId}`,
          { answers },
          { withCredentials: true }
        )
        .catch(() => {});
    }, 20000);
    return () => clearInterval(autoSaveTimer.current);
  }, [answers, submitted, testId, subjectId]);

  // ---- Submit ----
  const submitNow = async (reason = "manual") => {
    if (submitted || submitting) return;
    setSubmitting(true);
    setSubmitted(true);
    const url = `/student/tests/${testId}/submit?subject_id=${subjectId}`;
    const body = { answers };

    try {
      await api.post(url, body, { withCredentials: true });
      await exitFullScreen();
      alert("✅ Test submitted successfully!");
      navigate("/student/reports");
    } catch (e) {
      console.error("Submit failed:", e);
      await exitFullScreen();
      navigate("/student/reports");
    }
  };

  const handleSubmit = (reason = "manual") => submitNow(reason);

  // ---- Record violation ----
  const recordViolation = (reason) => {
    api
      .post(
        `/student/tests/${testId}/violation`,
        { reason },
        { withCredentials: true }
      )
      .catch(() => {});
  };

  // ---- Strict Lock System ----
  useEffect(() => {
    if (submitted) return;

    const MAX_WARNINGS = 3;

    const warn = (msg) => {
      violationCount.current += 1;
      recordViolation(msg);
      setToast(`⚠️ ${msg} (${violationCount.current}/${MAX_WARNINGS})`);
      setTimeout(() => setToast(""), 3000);

      if (violationCount.current >= MAX_WARNINGS) {
        alert("🚨 Too many violations! Test is being submitted.");
        submitNow("max-violations");
      } else {
        forceFullScreen();
      }
    };

    const handleVisibility = () => {
      if (document.hidden && !submitted) warn("Tab switch detected");
    };

    const handleFullScreenChange = () => {
      if (!document.fullscreenElement && !submitted) warn("Fullscreen exited");
    };

    const handleKeyDown = (e) => {
      if (
        ["Escape", "F11"].includes(e.key) ||
        (e.ctrlKey && ["r", "w", "t"].includes(e.key.toLowerCase())) ||
        (e.ctrlKey && e.shiftKey && e.key.toLowerCase() === "i")
      ) {
        e.preventDefault();
        e.stopPropagation();
        warn(`Restricted key used (${e.key})`);
      }
    };

    const handleContextMenu = (e) => {
      e.preventDefault();
      warn("Right-click detected");
    };

    document.addEventListener("visibilitychange", handleVisibility);
    document.addEventListener("fullscreenchange", handleFullScreenChange);
    document.addEventListener("keydown", handleKeyDown, true);
    document.addEventListener("contextmenu", handleContextMenu, true);

    forceFullScreen();

    return () => {
      document.removeEventListener("visibilitychange", handleVisibility);
      document.removeEventListener("fullscreenchange", handleFullScreenChange);
      document.removeEventListener("keydown", handleKeyDown, true);
      document.removeEventListener("contextmenu", handleContextMenu, true);
    };
  }, [submitted]);

  // ---- Prevent accidental tab close ----
  useEffect(() => {
    const handleBeforeUnload = (e) => {
      if (!submitted) {
        e.preventDefault();
        e.returnValue = "Your test progress will be lost!";
      }
    };
    window.addEventListener("beforeunload", handleBeforeUnload);
    return () => window.removeEventListener("beforeunload", handleBeforeUnload);
  }, [submitted]);

  if (loading)
    return (
      <div className="test-loader">
        <div className="spinner"></div>
        <p>Loading questions...</p>
      </div>
    );

  if (!questions.length) return <p>No questions found for this subject.</p>;

  const q = questions[current];
  const minutes = Math.floor(timeLeft / 60);
  const seconds = String(timeLeft % 60).padStart(2, "0");

  const isAnswered = (id) => answers[id];
  const isMarked = (id) => marked.includes(id);

  return (
    <div className="quiz-container" style={{ display: "flex", gap: "1.5rem" }}>
      {toast && (
        <div
          style={{
            position: "fixed",
            top: 70,
            left: "50%",
            transform: "translateX(-50%)",
            background: "#facc15",
            color: "#000",
            padding: "8px 12px",
            borderRadius: 6,
            zIndex: 2000,
          }}
        >
          {toast}
        </div>
      )}

      {submitting && (
        <div
          style={{
            position: "fixed",
            inset: 0,
            background: "rgba(0,0,0,0.6)",
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            zIndex: 9999,
            color: "white",
            fontSize: 18,
          }}
        >
          Submitting test...
        </div>
      )}

      {!started ? (
        <div style={{ textAlign: "center", padding: 32, width: "100%" }}>
          <h2>🧭 Ready to Start?</h2>
          <p>Once started, fullscreen will lock automatically.</p>
          <button className="btn green" onClick={handleStartTest}>
            Start Test
          </button>
        </div>
      ) : (
        <>
          <div style={{ flex: 3 }}>
            <header>
              <div className="title">
                <h2>
                  Exam - <span>{q.subject || "Subject"}</span>
                </h2>
                <p>Secure Mode Active — Don’t exit fullscreen or switch tabs.</p>
              </div>

              <div className="timer">
                <div className="timer-circle">
                  <svg height="70" width="70">
                    <circle
                      stroke="#4338ca"
                      strokeWidth="6"
                      fill="transparent"
                      r="30"
                      cx="35"
                      cy="35"
                    />
                  </svg>
                  <div className="timer-text">
                    {minutes}:{seconds}
                  </div>
                </div>
                <small>{submitted ? "Submitted" : "Time Left"}</small>
              </div>
            </header>

            <main>
              <div className="question-card">
                <h3>
                  Q{current + 1}. {q.question}
                </h3>

                <div className="options">
                  {["a", "b", "c", "d"].map((opt) => (
                    <label
                      key={opt}
                      className={`option-label ${
                        answers[q.question_id] === opt ? "selected" : ""
                      }`}
                      onClick={() =>
                        setAnswers((p) => ({ ...p, [q.question_id]: opt }))
                      }
                    >
                      <input
                        type="radio"
                        checked={answers[q.question_id] === opt}
                        readOnly
                      />
                      {q[`option_${opt}`]}
                    </label>
                  ))}
                </div>

                <div className="buttons">
                  <button
                    className="btn gray"
                    onClick={() => setCurrent(current - 1)}
                    disabled={current === 0}
                  >
                    Previous
                  </button>
                  <button
                    className="btn yellow"
                    onClick={() => setMarked([...marked, q.question_id])}
                  >
                    Mark Later
                  </button>
                  {current === questions.length - 1 ? (
                    <button
                      className="btn green"
                      onClick={() => submitNow("manual")}
                    >
                      Submit
                    </button>
                  ) : (
                    <button
                      className="btn pink"
                      onClick={() => setCurrent(current + 1)}
                    >
                      Next
                    </button>
                  )}
                </div>
              </div>

              {/* Legends */}
              <div
                style={{
                  display: "flex",
                  gap: "1rem",
                  justifyContent: "center",
                  marginTop: 24,
                }}
              >
                <Legend color="#22c55e" label="Answered" />
                <Legend color="#facc15" label="Marked for Review" />
                <Legend color="#d1d5db" label="Not Visited" />
              </div>
            </main>
          </div>

          {/* Question Navigation Sidebar */}
          <aside
            style={{
              flex: 1,
              borderLeft: "2px solid #e5e7eb",
              paddingLeft: "1rem",
              overflowY: "auto",
            }}
          >
            <h3 style={{ marginBottom: 10 }}>Question Navigator</h3>
            <div
              style={{
                display: "grid",
                gridTemplateColumns: "repeat(auto-fill, minmax(40px, 1fr))",
                gap: "8px",
              }}
            >
              {questions.map((ques, i) => {
                const bg = isAnswered(ques.question_id)
                  ? "#22c55e"
                  : isMarked(ques.question_id)
                  ? "#facc15"
                  : "#d1d5db";
                return (
                  <div
                    key={ques.question_id}
                    onClick={() => setCurrent(i)}
                    style={{
                      cursor: "pointer",
                      background: bg,
                      borderRadius: "6px",
                      color: "#000",
                      textAlign: "center",
                      padding: "6px 0",
                      fontWeight: current === i ? "bold" : "normal",
                      border: current === i ? "2px solid #000" : "none",
                    }}
                  >
                    {i + 1}
                  </div>
                );
              })}
            </div>
          </aside>
        </>
      )}
    </div>
  );
}

// small legend component
const Legend = ({ color, label }) => (
  <div style={{ display: "flex", alignItems: "center", gap: 8 }}>
    <span
      style={{
        width: 20,
        height: 20,
        background: color,
        borderRadius: 4,
        display: "inline-block",
      }}
    ></span>
    {label}
  </div>
);
