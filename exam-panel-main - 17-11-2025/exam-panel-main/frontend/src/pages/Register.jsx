import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import api from "../api";

export default function Register() {
  const navigate = useNavigate();
  const [form, setForm] = useState({
    name: "",
    email: "",
    mobile: "",
    city: "",
    stream_id: "",   // FIXED
    password: "",
    school: "",
    section: "",
  });

  const [streams, setStreams] = useState([]);
  const [error, setError] = useState("");
  const [success, setSuccess] = useState("");

  useEffect(() => {
    async function loadStreams() {
      try {
        const res = await api.get("/student/streams");
        setStreams(res.data.streams);
      } catch (err) {
        console.error("Error fetching streams", err);
      }
    }
    loadStreams();
  }, []);

  const handleChange = (e) =>
    setForm({ ...form, [e.target.name]: e.target.value });

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const res = await api.post("/student/register", form);
      setSuccess(res.data.message);
      setError("");
      setTimeout(() => navigate("/login"), 1500);
    } catch (err) {
      console.error(err);
      setError(err.response?.data?.error || "Registration failed");
      setSuccess("");
    }
  };

  return (
    <div className="register-container">
      <div className="register-card">
        <h1 className="title">🎓 Register Yourself in GQUEST</h1>

        {error && <p className="alert error">{error}</p>}
        {success && <p className="alert success">{success}</p>}

        <form onSubmit={handleSubmit} className="register-form">
          {["name", "email", "mobile", "city", "school", "section", "password"].map((field) => (
            <div className="form-group" key={field}>
              <input
                type={field === "password" ? "password" : "text"}
                name={field}
                required
                value={form[field]}
                onChange={handleChange}
                className="form-input"
                placeholder=" "
              />
              <label className="form-label">
                {field.charAt(0).toUpperCase() + field.slice(1)}
              </label>
            </div>
          ))}

          {/* Stream Dropdown */}
          <div className="form-group">
            <select
              name="stream_id"
              required
              value={form.stream_id}
              onChange={handleChange}
              className="form-input"
            >
              <option value="">Select Stream</option>
              {streams.map((s) => (
                <option key={s.id} value={s.id}>{s.name}</option>
              ))}
            </select>
            <label className="form-label">Stream</label>

          </div>

          <button type="submit" className="btn-primary">
            Register
          </button>

          <p className="login-link">
            Already have an account?{" "}
            <span onClick={() => navigate("/login")}>Login</span>
          </p>
        </form>
      </div>
    </div>
  );
}
