import { createContext, useContext, useEffect, useState } from "react";
import api from "../api";

const StudentContext = createContext();

export const StudentProvider = ({ children }) => {
  const [student, setStudent] = useState(null);
  const [loading, setLoading] = useState(true);

  const fetchStudent = async () => {
    try {
      const res = await api.get("/student/me", { withCredentials: true });
      setStudent(res.data.student);
    } catch (err) {
      console.warn("⚠️ Student not logged in or session expired.");
      setStudent(null);
    } finally {
      setLoading(false);
    }
  };

  const login = async (email, password) => {
    const res = await api.post(
      "/student/login",
      { email, password },
      { withCredentials: true }
    );
    setStudent(res.data.student);
  };

  const logout = async () => {
    try {
      await api.post("/student/logout", {}, { withCredentials: true });
    } catch (err) {
      console.error("Logout failed:", err);
    } finally {
      setStudent(null);
    }
  };

  useEffect(() => {
    fetchStudent();
  }, []);

  return (
    <StudentContext.Provider
      value={{ student, loading, login, logout, fetchStudent }}
    >
      {children}
    </StudentContext.Provider>
  );
};

export const useStudent = () => useContext(StudentContext);
