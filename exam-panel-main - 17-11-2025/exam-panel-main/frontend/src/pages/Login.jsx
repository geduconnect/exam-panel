import { useState } from "react";
import { useNavigate, Link } from "react-router-dom";
import { useStudent } from "../context/StudentContext";
import api from "../api";

export default function Login() {
  const navigate = useNavigate();
  const { fetchStudent } = useStudent();

  const [form, setForm] = useState({ email: "", password: "" });
  const [error, setError] = useState("");
  const [success, setSuccess] = useState("");
  const [loading, setLoading] = useState(false);

  const handleChange = (e) =>
    setForm({ ...form, [e.target.name]: e.target.value });

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");
    setSuccess("");
    setLoading(true);

    try {
      const res = await api.post("/student/login", form, {
        withCredentials: true,
      });

      if (res.data?.student) {
        setSuccess("✅ Login successful!");
        await fetchStudent();
        navigate("/student/dashboard");
      } else {
        setError("Unexpected server response. Please try again.");
      }
    } catch (err) {
      console.error("Login error:", err);
      setError(err.response?.data?.error || "❌ Invalid credentials");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="login-section">
      <div className="login-container">
        <h2 className="login-title">Welcome Back 👋</h2>
        <p className="login-subtitle">Log in to your Student Account</p>

        {error && <div className="alert alert-error">{error}</div>}
        {success && <div className="alert alert-success">{success}</div>}

        <form onSubmit={handleSubmit} className="login-form">
          <input
            type="email"
            name="email"
            placeholder="Email"
            className="login-input"
            value={form.email}
            onChange={handleChange}
            required
          />
          <input
            type="password"
            name="password"
            placeholder="Password"
            className="login-input"
            value={form.password}
            onChange={handleChange}
            required
          />

          <button type="submit" className="login-btn" disabled={loading}>
            {loading ? "Logging in..." : "Log In"}
          </button>

          {/* 🔗 Forgot Password Link */}
          <div className="forgot-password">
            <Link to="/forgot-password">Forgot Password?</Link>
          </div>
        </form>
      </div>
    </div>
  );
}
