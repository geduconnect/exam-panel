import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { useStudent } from "../context/StudentContext";
import { Menu } from "lucide-react";

export default function Navbar({ onToggleSidebar }) {
  const navigate = useNavigate();
  const { logout, student } = useStudent();
  const [openMenu, setOpenMenu] = useState(false);

  const handleLogout = async () => {
    await logout();
    navigate("/login");
  };

  return (
    <nav className="student-navbar">

      {/* LEFT: Hamburger + Brand */}
      <div className="nav-left" style={{ display: "flex", alignItems: "center", gap: "12px" }}>

        {/* Show toggle only when logged in */}
        {student && (
          <button
            className="sidebar-toggle-btn"
            onClick={onToggleSidebar}
          >
            <Menu size={24} />
          </button>
        )}

        <h2
          className="nav-brand"
          onClick={() =>
            student ? navigate("/student/dashboard") : navigate("/login")
          }
        >
          🎓 GQUEST
        </h2>
      </div>

      {/* RIGHT DROPDOWN */}
      {student && (
        <div className="nav-right">
          <div
            className="profile-box"
            onClick={() => setOpenMenu(!openMenu)}
          >
            <img
              src={student?.avatar || "/default-avatar.png"}
              alt="avatar"
              className="student-avatar"
            />
            <span className="student-name">{student?.name}</span>
          </div>

          {openMenu && (
            <div className="dropdown-menu">
              <button onClick={() => navigate("/student/dashboard")}>🧭 Dashboard</button>
              <button onClick={() => navigate("/profile")}>👤 Profile</button>
              <button onClick={handleLogout} className="logout-btn">🚪 Logout</button>
            </div>
          )}
        </div>
      )}
    </nav>
  );
}
