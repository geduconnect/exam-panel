import { useState } from "react";
import { useNavigate } from "react-router-dom";
import api from "../api";

export default function ForgotPassword() {
  const [email, setEmail] = useState("");
  const [message, setMessage] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setMessage("");
    setError("");
    setLoading(true);

    try {
      const res = await api.post("/student/forgot-password", { email });
      setMessage(res.data?.message || "✅ Reset link sent to your email!");
    } catch (err) {
      console.error("Forgot password error:", err);
      setError(err.response?.data?.error || "❌ Something went wrong!");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="forgot-section">
      <div className="forgot-container">
        <h2 className="forgot-title">Forgot Password 🔒</h2>
        <p className="forgot-subtitle">
          Enter your registered email to receive reset instructions
        </p>

        {error && <div className="alert alert-error">{error}</div>}
        {message && <div className="alert alert-success">{message}</div>}

        <form onSubmit={handleSubmit} className="forgot-form">
          <input
            type="email"
            placeholder="Enter your email"
            className="login-input"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
          />
          <button type="submit" className="login-btn" disabled={loading}>
            {loading ? "Sending..." : "Send Reset Link"}
          </button>
        </form>

        <button
          onClick={() => navigate("/login")}
          className="back-btn"
          style={{ marginTop: "10px" }}
        >
          ← Back to Login
        </button>
      </div>
    </div>
  );
}
