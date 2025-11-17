import { useEffect, useState } from "react";
import api from "../api";
import { useNavigate } from "react-router-dom";

export default function AdminProfile() {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(true);
  const [admin, setAdmin] = useState(null);
  const [name, setName] = useState("");
  const [password, setPassword] = useState("");
  const [success, setSuccess] = useState("");

  // Fetch Profile
  const fetchProfile = async () => {
    try {
      const res = await api.get("/admin/check-session");

      if (!res.data.user) return navigate("/");

      setAdmin(res.data.user);
      setName(res.data.user.name || "");
      setLoading(false);
    } catch (err) {
      console.error("Profile fetch failed:", err);
      navigate("/");
    }
  };

  // Update Profile
  const handleUpdate = async (e) => {
    e.preventDefault();
    try {
      await api.put("/admin/update-profile", {
        name,
        password: password || null,
      });

      setSuccess("Profile updated successfully!");
      setPassword("");
      fetchProfile();
    } catch (err) {
      console.error("Update failed:", err);
    }
  };

  useEffect(() => {
    fetchProfile();
  }, []);

  if (loading) return <p className="p-6">Loading...</p>;

  return (
    <div className="max-w-xl mx-auto mt-10 bg-white p-6 rounded-lg shadow">
      <h2 className="text-2xl font-bold mb-4">Admin Profile</h2>

      {success && (
        <p className="mb-4 bg-green-100 text-green-800 p-2 rounded">
          {success}
        </p>
      )}

      <form onSubmit={handleUpdate} className="space-y-4">

        <div>
          <label className="block mb-1 font-medium">Full Name</label>
          <input
            className="w-full border rounded p-2"
            value={name}
            onChange={(e) => setName(e.target.value)}
          />
        </div>

        <div>
          <label className="block mb-1 font-medium">Email</label>
          <input
            className="w-full border rounded p-2 bg-gray-100"
            value={admin?.email || ""}
            readOnly
          />
        </div>

        <div>
          <label className="block mb-1 font-medium">Role</label>
          <input
            className="w-full border rounded p-2 bg-gray-100"
            value={admin?.role || ""}
            readOnly
          />
        </div>

        <div>
          <label className="block mb-1 font-medium">New Password</label>
          <input
            type="password"
            className="w-full border rounded p-2"
            value={password}
            placeholder="Leave empty if not changing"
            onChange={(e) => setPassword(e.target.value)}
          />
        </div>

        <button className="bg-blue-600 text-white px-4 py-2 rounded">
          Update Profile
        </button>
      </form>
    </div>
  );
}
