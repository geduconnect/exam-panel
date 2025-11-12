import React, { useState, useEffect } from "react";
import api from "../../api";

export default function TestManager() {
  const [tests, setTests] = useState([]);
  const [formData, setFormData] = useState({
    name: "",
    total_duration: 90,
    randomize_within_chapter: true,
  });

  const [setCount, setSetCount] = useState(3);

  useEffect(() => {
    fetchTests();
  }, []);

  const fetchTests = async () => {
    const res = await api.get("/admin/tests");
    setTests(res.data);
  };

  const handleCreateTest = async (e) => {
    e.preventDefault();
    const res = await api.post("/admin/tests", formData);
    alert("✅ Test created successfully!");
    fetchTests();
  };

  const handleGenerateSets = async (testId) => {
    await api.post(`/admin/tests/${testId}/generate-sets`, { setCount });
    alert("✅ Sets created!");
  };

  const handlePopulate = async (testId) => {
    await api.post(`/admin/tests/${testId}/populate-questions`);
    alert("✅ Questions populated!");
  };

  return (
    <div className="p-6 bg-gray-50 min-h-screen">
      <h2 className="text-2xl font-bold text-center mb-6">🧾 Test Manager</h2>

      {/* Create Test Form */}
      <div className="bg-white shadow p-6 rounded-lg max-w-3xl mx-auto mb-10">
        <form onSubmit={handleCreateTest} className="space-y-4">
          <input
            type="text"
            name="name"
            placeholder="Test Name"
            value={formData.name}
            onChange={(e) => setFormData({ ...formData, name: e.target.value })}
            className="border p-2 rounded w-full"
            required
          />
          <input
            type="number"
            name="total_duration"
            placeholder="Total Duration (min)"
            value={formData.total_duration}
            onChange={(e) =>
              setFormData({ ...formData, total_duration: e.target.value })
            }
            className="border p-2 rounded w-full"
          />
          <label className="flex items-center gap-2">
            <input
              type="checkbox"
              checked={formData.randomize_within_chapter}
              onChange={(e) =>
                setFormData({
                  ...formData,
                  randomize_within_chapter: e.target.checked,
                })
              }
            />
            Randomize within chapters
          </label>

          <button
            type="submit"
            className="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700"
          >
            Create Test
          </button>
        </form>
      </div>

      {/* Tests Table */}
      <div className="bg-white shadow p-6 rounded-lg max-w-5xl mx-auto">
        <h3 className="text-lg font-semibold mb-4">All Tests</h3>
        <table className="w-full border">
          <thead>
            <tr className="bg-gray-100">
              <th className="border p-2">Name</th>
              <th className="border p-2">Duration</th>
              <th className="border p-2">Randomization</th>
              <th className="border p-2">Actions</th>
            </tr>
          </thead>
          <tbody>
            {tests.map((t) => (
              <tr key={t.id}>
                <td className="border p-2">{t.name}</td>
                <td className="border p-2">{t.total_duration} min</td>
                <td className="border p-2">
                  {t.randomize_within_chapter ? "Yes" : "No"}
                </td>
                <td className="border p-2 space-x-2">
                  <button
                    onClick={() => handleGenerateSets(t.id)}
                    className="bg-yellow-500 text-white px-3 py-1 rounded"
                  >
                    Generate Sets
                  </button>
                  <button
                    onClick={() => handlePopulate(t.id)}
                    className="bg-green-600 text-white px-3 py-1 rounded"
                  >
                    Populate
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
