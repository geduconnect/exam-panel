import { NavLink } from "react-router-dom";
import { useEffect, useState } from "react";

export default function Sidebar({ isOpen }) {
  const [open, setOpen] = useState(isOpen);

  useEffect(() => {
    setOpen(isOpen);
  }, [isOpen]);

  return (
    <div
      className="student-sidebar"
      style={{
        width: open ? "220px" : "70px",
        transition: "0.3s ease",
        overflow: "hidden",
      }}
    >
      <nav className="sidebar-menu">

        <NavLink to="/student/dashboard" className="sidebar-link">
          <span className="icon">📊</span>
          {open && <span className="text">Dashboard</span>}
        </NavLink>

        <NavLink to="/student/reports" className="sidebar-link">
          <span className="icon">📄</span>
          {open && <span className="text">Reports</span>}
        </NavLink>

        <NavLink to="/profile" className="sidebar-link">
          <span className="icon">👤</span>
          {open && <span className="text">Profile</span>}
        </NavLink>

      </nav>
    </div>
  );
}
