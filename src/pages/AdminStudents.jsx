import { useEffect, useState } from "react";
import api from "../api";
import Navbar from "../components/Navbar";

export default function AdminStudents() {
  const [students, setStudents] = useState([]);
  const [streams, setStreams] = useState([]);
  const [error, setError] = useState("");
  const [feedback, setFeedback] = useState("");
  const [modalOpen, setModalOpen] = useState(false);
  const [selectedStudent, setSelectedStudent] = useState(null);

  const [resetModalOpen, setResetModalOpen] = useState(false);
  const [resetInfo, setResetInfo] = useState({ email: "", password: "" });

  const [form, setForm] = useState({
    name: "",
    email: "",
    mobile: "",
    city: "",
    stream_id: "",
  });

  // ---------------------------
  // Fetch Students
  // ---------------------------
  const fetchStudents = async () => {
    try {
      const res = await api.get("/admin/students");
      setStudents(res.data.students);
    } catch (err) {
      console.error("Error fetching students:", err);
      setError("Failed to fetch student data");
    }
  };

  // ---------------------------
  // Fetch Streams
  // ---------------------------
  const fetchStreams = async () => {
    try {
      const res = await api.get("/admin/streams");
      setStreams(res.data);
    } catch (err) {
      console.error("Error fetching streams:", err);
      setError("Failed to fetch streams");
    }
  };

  useEffect(() => {
    fetchStudents();
    fetchStreams();
  }, []);

  // ---------------------------
  // Delete Student
  // ---------------------------
  const handleDelete = async (id) => {
    if (!window.confirm("Are you sure you want to delete this student?")) return;
    try {
      await api.delete(`/admin/students/${id}`);
      fetchStudents();
    } catch (err) {
      console.error("Error deleting student:", err);
      setError("Failed to delete student");
    }
  };

  // ---------------------------
  // Open Edit Modal
  // ---------------------------
  const openEditModal = (student) => {
    setSelectedStudent(student);
    setForm({
      name: student.name,
      email: student.email,
      mobile: student.mobile,
      city: student.city,
      stream_id: student.stream_id || "",
    });
    setModalOpen(true);
  };

  // ---------------------------
  // Save Student
  // ---------------------------
  const handleSave = async () => {
    try {
      if (!form.name || !form.email || !form.mobile || !form.city || !form.stream_id) {
        setFeedback("⚠️ All fields are required!");
        return;
      }

      if (!selectedStudent) {
        await api.post("/admin/students", form);
        setFeedback("✅ Student added successfully");
      } else {
        await api.put(`/admin/students/${selectedStudent.id}`, form);
        setFeedback("✅ Student updated successfully");
      }

      fetchStudents();
      setTimeout(() => {
        setModalOpen(false);
        setFeedback("");
      }, 1500);
    } catch (err) {
      console.error("Error saving student:", err);
      setFeedback(err.response?.data?.error || "❌ Failed to save student");
    }
  };

  // ---------------------------
  // Reset Password (Admin Action)
  // ---------------------------
  const handleResetPassword = async (id, email) => {
    if (!window.confirm(`Reset password for ${email}?`)) return;

    try {
      const newPassword = Math.random().toString(36).slice(-8);

      await api.put(`/admin/students/${id}/reset-password`, {
        password: newPassword,
      });

      // ✅ Open custom modal with password info
      setResetInfo({ email, password: newPassword });
      setResetModalOpen(true);
      fetchStudents();
    } catch (err) {
      console.error("Error resetting password:", err);
      alert(err.response?.data?.error || "❌ Failed to reset password");
    }
  };

  const copyToClipboard = () => {
    navigator.clipboard.writeText(resetInfo.password);
    alert("📋 Password copied to clipboard!");
  };

  return (
    <div className="admin-container">
      <Navbar />
      <h2 className="title">Registered Students</h2>
      {error && <p className="error">{error}</p>}

      <button
        className="add-btn"
        onClick={() => {
          setSelectedStudent(null);
          setForm({ name: "", email: "", mobile: "", city: "", stream_id: "" });
          setModalOpen(true);
        }}
      >
        + Add Student
      </button>

      <table className="student-table">
        <thead>
          <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Mobile</th>
            <th>City</th>
            <th>Stream</th>
            <th>Registered On</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {students.length > 0 ? (
            students.map((s) => {
              const streamName = streams.find((st) => st.id === s.stream_id)?.name || "—";
              return (
                <tr key={s.id}>
                  <td>{s.id}</td>
                  <td>{s.name}</td>
                  <td>{s.email}</td>
                  <td>{s.mobile}</td>
                  <td>{s.city}</td>
                  <td>{streamName}</td>
                  <td>{new Date(s.created_at).toLocaleString()}</td>
                  <td>
                    <button className="edit-btn" onClick={() => openEditModal(s)}>
                      Edit
                    </button>
                    <button className="delete-btn" onClick={() => handleDelete(s.id)}>
                      Delete
                    </button>
                    <button
                      className="reset-btn"
                      onClick={() => handleResetPassword(s.id, s.email)}
                    >
                      Reset Password
                    </button>
                  </td>
                </tr>
              );
            })
          ) : (
            <tr>
              <td colSpan="8">No students found</td>
            </tr>
          )}
        </tbody>
      </table>

      {/* Add/Edit Modal */}
      {modalOpen && (
        <div className="modal-overlay">
          <div className="modal">
            <h3>{selectedStudent ? "Edit Student" : "Add Student"}</h3>

            <input
              placeholder="Name"
              value={form.name}
              onChange={(e) => setForm({ ...form, name: e.target.value })}
            />
            <input
              placeholder="Email"
              value={form.email}
              onChange={(e) => setForm({ ...form, email: e.target.value })}
            />
            <input
              placeholder="Mobile"
              value={form.mobile}
              onChange={(e) => setForm({ ...form, mobile: e.target.value })}
            />
            <input
              placeholder="City"
              value={form.city}
              onChange={(e) => setForm({ ...form, city: e.target.value })}
            />

            <select
              value={form.stream_id}
              onChange={(e) => setForm({ ...form, stream_id: e.target.value })}
            >
              <option value="">Select Stream</option>
              {streams.map((stream) => (
                <option key={stream.id} value={stream.id}>
                  {stream.name}
                </option>
              ))}
            </select>

            {feedback && <p className="feedback">{feedback}</p>}

            <div className="modal-actions">
              <button className="cancel-btn" onClick={() => setModalOpen(false)}>
                Cancel
              </button>
              <button className="save-btn" onClick={handleSave}>
                Save
              </button>
            </div>
          </div>
        </div>
      )}

      {/* ✅ Reset Password Modal */}
      {resetModalOpen && (
        <div className="modal-overlay">
          <div className="modal">
            <h3>Password Reset Successful</h3>
            <p>
              <strong>{resetInfo.email}</strong>'s new password:
            </p>
            <div className="password-box">
              <code>{resetInfo.password}</code>
            </div>

            <div className="modal-actions">
              <button className="copy-btn" onClick={copyToClipboard}>
                📋 Copy Password
              </button>
              <button className="close-btn" onClick={() => setResetModalOpen(false)}>
                Close
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
