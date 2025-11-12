import { useEffect, useState } from "react";
import api from "../api";
import { useStudent } from "../context/StudentContext";

export default function Profile() {
  const { fetchStudent } = useStudent();

  const [student, setStudent] = useState({
    name: "",
    email: "",
    mobile: "",
    city: "",
    stream_id: "", // ✅ use stream_id instead of stream
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
          stream_id: st.stream_id || "", // ✅ assign ID
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
    <div className="login-section">
      <div className="login-container">
        <h2 className="login-title">My Profile</h2>
        <p className="login-subtitle">Manage your details & password</p>

        {/* Profile Update */}
        <form onSubmit={handleUpdateProfile} className="login-form">
          <input
            type="text"
            placeholder="Full Name"
            className="login-input"
            value={student.name}
            onChange={(e) => setStudent({ ...student, name: e.target.value })}
            required
          />
          <input
            type="email"
            placeholder="Email"
            className="login-input"
            value={student.email}
            onChange={(e) => setStudent({ ...student, email: e.target.value })}
            required
          />
          <input
            type="text"
            placeholder="Mobile"
            className="login-input"
            value={student.mobile}
            onChange={(e) => setStudent({ ...student, mobile: e.target.value })}
            required
          />
          <input
            type="text"
            placeholder="City"
            className="login-input"
            value={student.city}
            onChange={(e) => setStudent({ ...student, city: e.target.value })}
            required
          />

          {/* ✅ Stream Dropdown */}
          <select
            className="login-input"
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

          <button type="submit" className="login-btn">
            Update Profile
          </button>

          {msg && (
            <div
              className={`alert ${
                msg.includes("❌") ? "alert-error" : "alert-success"
              }`}
            >
              {msg}
            </div>
          )}
        </form>

        <hr className="divider" />

        {/* Password Change */}
        <form onSubmit={handleChangePassword} className="login-form">
          <input
            type="password"
            placeholder="Old Password"
            className="login-input"
            value={passwords.oldPassword}
            onChange={(e) =>
              setPasswords({ ...passwords, oldPassword: e.target.value })
            }
            required
          />
          <input
            type="password"
            placeholder="New Password"
            className="login-input"
            value={passwords.newPassword}
            onChange={(e) =>
              setPasswords({ ...passwords, newPassword: e.target.value })
            }
            required
          />
          <button type="submit" className="login-btn">
            Change Password
          </button>

          {passMsg && (
            <div
              className={`alert ${
                passMsg.includes("❌") ? "alert-error" : "alert-success"
              }`}
            >
              {passMsg}
            </div>
          )}
        </form>
      </div>
    </div>
  );
}
