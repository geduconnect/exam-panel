import { useEffect, useState } from "react";
import api from "../api";
import { useStudent } from "../context/StudentContext";
import { useNavigate } from "react-router-dom";
import { FaBars, FaHome, FaFileAlt, FaUser } from "react-icons/fa";
export default function Profile() {
  const { fetchStudent } = useStudent();
  const [isCollapsed, setIsCollapsed] = useState(false);
  const navigate = useNavigate();
  const [student, setStudent] = useState({
    name: "",
    email: "",
    mobile: "",
    city: "",
    stream_id: "", // ✅ use stream_id instead of stream
    school: "",
    section: "",
  });

  const [streams, setStreams] = useState([]);
  const [passwords, setPasswords] = useState({ oldPassword: "", newPassword: "" });
  const [msg, setMsg] = useState("");
  const [passMsg, setPassMsg] = useState("");

  // -------------------------------
  // Fetch logged-in student
  // -------------------------------
useEffect(() => {
  const fetchProfile = async () => {
    try {
      const res = await api.get("/student/me", { withCredentials: true });
      const st = res.data.student;

      setStudent({
        name: st.name || "",
        email: st.email || "",
        mobile: st.mobile || "",
        city: st.city || "",
        stream_id: st.stream_id ? String(st.stream_id) : "",
        school: st.school || "",
        section: st.section || "",
      });

    } catch (err) {
      console.error("Fetch profile failed:", err);
      setMsg("❌ Failed to fetch profile");
    }
  };

  fetchProfile();
}, []);

  // -------------------------------
  // Fetch Streams from Backend
  // -------------------------------
  useEffect(() => {
    const fetchStreams = async () => {
      try {
        const res = await api.get("/admin/streams", { withCredentials: true });
        setStreams(res.data || []);
      } catch (err) {
        console.error("Failed to fetch streams:", err);
      }
    };
    fetchStreams();
  }, []);

  // -------------------------------
  // Update Profile
  // -------------------------------
  const handleUpdateProfile = async (e) => {
    e.preventDefault();
    try {
      const res = await api.put("/student/update", student, { withCredentials: true });
      setMsg("✅ " + res.data.message);
      await fetchStudent();
    } catch (err) {
      console.error("Update error:", err);
      setMsg(err.response?.data?.error || "❌ Failed to update profile");
    } finally {
      setTimeout(() => setMsg(""), 4000);
    }
  };

  // -------------------------------
  // Change Password
  // -------------------------------
  const handleChangePassword = async (e) => {
    e.preventDefault();
    try {
      const res = await api.put("/student/change-password", passwords, {
        withCredentials: true,
      });
      setPassMsg("✅ " + res.data.message);
      setPasswords({ oldPassword: "", newPassword: "" });
    } catch (err) {
      console.error("Password change error:", err);
      setPassMsg(err.response?.data?.error || "❌ Failed to change password");
    } finally {
      setTimeout(() => setPassMsg(""), 4000);
    }
  };

  return (
    <>
      <div className="profile-section">



        <div className="profile-grid">

          {/* LEFT: UPDATE PROFILE */}
          <div className="profile-card">
            <h2 className="profile-title">My Profile</h2>
            <p className="profile-subtitle">Manage your details</p>

            <form onSubmit={handleUpdateProfile} className="profile-form">
              <input
                type="text"
                placeholder="Full Name"
                className="profile-input"
                value={student.name}
                onChange={(e) => setStudent({ ...student, name: e.target.value })}
                required
              />

              <input
                type="email"
                placeholder="Email"
                className="profile-input"
                value={student.email}
                onChange={(e) => setStudent({ ...student, email: e.target.value })}
                required
              />

              <input
                type="text"
                placeholder="Mobile"
                className="profile-input"
                value={student.mobile}
                onChange={(e) => setStudent({ ...student, mobile: e.target.value })}
                required
              />

              <input
                type="text"
                placeholder="City"
                className="profile-input"
                value={student.city}
                onChange={(e) => setStudent({ ...student, city: e.target.value })}
                required
              />
              <input
                type="text"
                placeholder="school"
                className="profile-input"
                value={student.school}
                onChange={(e) => setStudent({ ...student, school: e.target.value })}
                required
              />
              <input
                type="text"
                placeholder="section"
                className="profile-input"
                value={student.section}
                onChange={(e) => setStudent({ ...student, section: e.target.value })}
                required
              />

              <select
                className="profile-input"
                value={student.stream_id || ""}
                onChange={(e) =>
                  setStudent({ ...student, stream_id: e.target.value })
                }
                required
              >
                <option value="">Select Stream</option>
                {streams.map((stream) => (
                  <option key={stream.id} value={stream.id}>
                    {stream.name}
                  </option>
                ))}
              </select>

              <button type="submit" className="profile-btn">
                Update Profile
              </button>

              {msg && (
                <div
                  className={`alert ${msg.includes("❌") ? "alert-error" : "alert-success"
                    }`}
                >
                  {msg}
                </div>
              )}
            </form>
          </div>

          {/* RIGHT: CHANGE PASSWORD */}
          <div className="profile-card">
            <h2 className="profile-title">Change Password</h2>
            <p className="profile-subtitle">Keep your account secure</p>

            <form onSubmit={handleChangePassword} className="profile-form">
              <input
                type="password"
                placeholder="Old Password"
                className="profile-input"
                value={passwords.oldPassword}
                onChange={(e) =>
                  setPasswords({ ...passwords, oldPassword: e.target.value })
                }
                required
              />

              <input
                type="password"
                placeholder="New Password"
                className="profile-input"
                value={passwords.newPassword}
                onChange={(e) =>
                  setPasswords({ ...passwords, newPassword: e.target.value })
                }
                required
              />

              <button type="submit" className="profile-btn">
                Change Password
              </button>

              {passMsg && (
                <div
                  className={`alert ${passMsg.includes("❌") ? "alert-error" : "alert-success"
                    }`}
                >
                  {passMsg}
                </div>
              )}
            </form>
          </div>

        </div>
      </div>
    </>



  );
}
