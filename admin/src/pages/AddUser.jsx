import { useState } from "react";
import { useNavigate } from "react-router-dom";
import api from "../api";
import Navbar from "../components/Navbar";

export default function AddUser() {
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [role, setRole] = useState("admin");
  const [message, setMessage] = useState("");
  const navigate = useNavigate();

  const handleAddUser = async (e) => {
    e.preventDefault();
    setMessage("");

    try {
      const res = await api.post("/admin/add-user", {
        name,
        email,
        password,
        role,
      });
      setMessage("User created successfully!");
      setName("");
      setEmail("");
      setPassword("");
    } catch (err) {
      setMessage(err.response?.data?.error || "Failed to create user");
    }
  };

  return (
    <div className="p-6 bg-gray-50 min-h-screen">
      <h2 className="text-2xl font-bold mb-4">Add New Admin</h2>
      <form onSubmit={handleAddUser} className="bg-white p-6 rounded shadow-md w-96">
        <input
          type="text"
          placeholder="Name"
          className="border w-full p-2 mb-3"
          value={name}
          onChange={(e) => setName(e.target.value)}
          required
        />
        <input
          type="email"
          placeholder="Email"
          className="border w-full p-2 mb-3"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
        />
        <input
          type="password"
          placeholder="Password"
          className="border w-full p-2 mb-3"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          required
        />
        <select
          className="border w-full p-2 mb-3"
          value={role}
          onChange={(e) => setRole(e.target.value)}
        >
          <option value="admin">Admin</option>
          <option value="superadmin">Super Admin</option>
        </select>
        {message && <p className="text-green-600 mb-2">{message}</p>}
        <button
          type="submit"
          className="bg-green-500 text-white w-full p-2 rounded hover:bg-green-600"
        >
          Add User
        </button>
      </form>
    </div>
  );
}
