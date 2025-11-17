// ProtectedRoute.jsx
import { Navigate } from "react-router-dom";
import { useEffect, useState } from "react";
import api from "./api";

export default function ProtectedRoute({ children }) {
  const [loading, setLoading] = useState(true);
  const [loggedIn, setLoggedIn] = useState(false);

  useEffect(() => {
    const checkLogin = async () => {
      try {
        const res = await api.get("/admin/check-session");
        if (res.data.user) {
          setLoggedIn(true);
        }
      } catch (err) {
        setLoggedIn(false);
      }
      setLoading(false);
    };

    checkLogin();
  }, []);

  if (loading) return <p>Loading...</p>;

  return loggedIn ? children : <Navigate to="/" replace />;
}
