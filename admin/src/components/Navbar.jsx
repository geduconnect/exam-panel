import { useState } from "react";
import { useNavigate } from "react-router-dom";
import api from "../api";
import { Menu, User, LogOut } from "lucide-react";

export default function Navbar({ toggleSidebar }) {
  const navigate = useNavigate();
  const [menuOpen, setMenuOpen] = useState(false);

  const handleLogout = async () => {
    try {
      await api.post("/admin/logout");
      navigate("/");
    } catch (error) {
      console.error("Logout failed:", error);
    }
  };

  return (
    <nav className="navbar">
      {/* Left: Sidebar toggle + logo/title */}
      <div className="navbar-left">
        <button onClick={toggleSidebar} className="navbar-menu-btn">
          <Menu size={22} />
        </button>

        <h1 className="navbar-title" onClick={() => navigate("/dashboard")}>
          Admin Panel
        </h1>
      </div>

      {/* Right: Profile dropdown */}
      <div className="navbar-right">
        <div className="profile-section">
          <button
            className="profile-btn"
            onClick={() => setMenuOpen(!menuOpen)}
          >
            <User size={20} />
          </button>

          {menuOpen && (
            <div className="profile-dropdown">
              <button
                onClick={() => {
                  navigate("/profile");
                  setMenuOpen(false);
                }}
              >
                <User size={16} /> Profile
              </button>
              <button className="logout" onClick={handleLogout}>
                <LogOut size={16} /> Logout
              </button>
            </div>
          )}
        </div>
      </div>
    </nav>
  );
}
