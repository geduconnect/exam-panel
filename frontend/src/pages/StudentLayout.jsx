import React from "react";
import { NavLink, Outlet, useNavigate } from "react-router-dom";
import { Home, ClipboardList, FileQuestion, LogOut } from "lucide-react";

export default function StudentLayout() {
  const navigate = useNavigate();

  return (
    <div className="student-layout">
      {/* ===== SIDEBAR ===== */}
      <aside className="student-sidebar">
        <div className="sidebar-header">
          <h2>🎓 GQUEST</h2>
          <p>Student Portal</p>
        </div>

        <nav className="sidebar-menu">
          <NavLink to="/student/dashboard" className="sidebar-link">
            <Home size={18} /> Dashboard
          </NavLink>
          <NavLink to="/student/tests" className="sidebar-link">
            <ClipboardList size={18} /> My Tests
          </NavLink>
          <NavLink to="/student/test" className="sidebar-link">
            <FileQuestion size={18} /> Take Test
          </NavLink>
        </nav>

        <button
          className="logout-btn"
          onClick={() => navigate("/student/logout")}
        >
          <LogOut size={18} /> Logout
        </button>
      </aside>

      {/* ===== MAIN CONTENT ===== */}
      <main className="student-main">
        <Outlet />
      </main>
    </div>
  );
}
