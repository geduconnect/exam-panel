import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import Navbar from "./components/Navbar";
import Login from "./pages/Login";
import Profile from "./pages/Profile";
import { useStudent } from "./context/StudentContext.jsx";
import Register from "./pages/Register.jsx";
import "./App.css";
import StudentTests from "./pages/StudentTests.jsx";
import StudentExamPage from "./pages/StudentExamPage.jsx";
import StudentDashboard from "./pages/Dashboard.jsx";
import StudentReportsView from "./pages/StudentReportsView.jsx";
import StudentReport from "./pages/StudentTestReport.jsx";
import ForgotPassword from "./pages/ForgotPassword.jsx";
import Sidebar from "./components/Sidebar.jsx";
import { useState } from "react";

export default function App() {
  const { student, loading } = useStudent();
  const [sidebarOpen, setSidebarOpen] = useState(true);

  if (loading) return <p>Loading...</p>;

  return (
    <BrowserRouter>
      {/* SIDEBAR ONLY IF LOGGED IN */}
      {student && <Sidebar open={sidebarOpen} />}

      {/* NAVBAR */}
      <Navbar onToggleSidebar={() => setSidebarOpen((prev) => !prev)} />

      {/* MAIN CONTENT (CSS controlled, no inline conflict) */}
      <div
        className={`app-main ${sidebarOpen && student ? "sidebar-open" : ""}`}
      >
        <Routes>
          <Route path="/" element={<Navigate to="/register" />} />

          <Route
            path="/register"
            element={!student ? <Register /> : <Navigate to="/student/dashboard" />}
          />

          <Route
            path="/login"
            element={!student ? <Login /> : <Navigate to="/student/dashboard" />}
          />

          <Route
            path="/forgot-password"
            element={
              !student ? <ForgotPassword /> : <Navigate to="/student/dashboard" />
            }
          />

          <Route
            path="/student/dashboard"
            element={student ? <StudentDashboard /> : <Navigate to="/login" />}
          />

          <Route
            path="/profile"
            element={student ? <Profile /> : <Navigate to="/login" />}
          />

          {/* Test list */}
          <Route
            path="/student/tests"
            element={student ? <StudentTests /> : <Navigate to="/login" />}
          />

          {/* Exam page */}
          <Route
            path="/student/exam/:testId/:subjectId"
            element={student ? <StudentExamPage /> : <Navigate to="/login" />}
          />

          {/* Reports */}
          <Route
            path="/student/reports"
            element={student ? <StudentReportsView /> : <Navigate to="/login" />}
          />

          <Route
            path="/student/report/:testId"
            element={student ? <StudentReport /> : <Navigate to="/login" />}
          />
        </Routes>
      </div>
    </BrowserRouter>
  );
}
