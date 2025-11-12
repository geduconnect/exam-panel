import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { useStudent } from "../context/StudentContext";

export default function Navbar() {
  const navigate = useNavigate();
  const { logout, student } = useStudent();
  const [openMenu, setOpenMenu] = useState(false);

  const handleLogout = async () => {
    await logout();
    navigate("/login");
  };

  return (
    <nav className="student-navbar">
      <div
        className="nav-left"
        onClick={() => navigate("/student/dashboard")}
      >
        <h2 className="nav-brand">🎓 GQUEST</h2>
      </div>

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
          <span className="student-name">
            {student?.name || "Student"}
          </span>
        </div>

        {openMenu && (
          <div className="dropdown-menu">
            <button onClick={() => navigate("/student/dashboard")}>
              🧭 Dashboard
            </button>
            <button onClick={() => navigate("/profile")}>
              👤 Profile
            </button>
            <button onClick={handleLogout} className="logout-btn">
              🚪 Logout
            </button>
          </div>
        )}
      </div>
    </nav>
  );
}
