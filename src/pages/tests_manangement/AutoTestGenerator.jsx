import React, { useEffect, useState } from "react";
import api from "../../api";

export default function AutoTestGenerator() {
  const [streams, setStreams] = useState([]);
  const [selectedStream, setSelectedStream] = useState("");
  const [questionsPerLevel, setQuestionsPerLevel] = useState(2);
  const [testName, setTestName] = useState("");
  const [duration, setDuration] = useState(60); // default 60 min
  const [loading, setLoading] = useState(false);
  const [result, setResult] = useState(null);

  useEffect(() => {
    fetchStreams();
  }, []);

  const fetchStreams = async () => {
    try {
      const res = await api.get("/admin/streams");
      setStreams(res.data);
    } catch (err) {
      console.error("❌ Error fetching streams:", err);
    }
  };

  const handleGenerate = async () => {
    if (!selectedStream) return alert("Please select a stream");
    if (!testName.trim()) return alert("Please enter a test name");

    setLoading(true);
    setResult(null);
    try {
      const res = await api.post("/admin/tests/create-balanced", {
        stream_id: selectedStream,
        questionsPerLevel: Number(questionsPerLevel),
        testName,
        duration,
      });
      setResult(res.data);
    } catch (err) {
      console.error("❌ Error generating test:", err);
      alert("Failed to auto-generate test");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="p-8 bg-gray-50 min-h-screen">
      <h2 className="text-2xl font-bold mb-6 text-center">
        ⚙️ Auto Test Generator
      </h2>

      <div className="max-w-xl mx-auto bg-white shadow-md rounded-xl p-6 space-y-5">
        {/* Stream Selection */}
        <div>
          <label className="block mb-2 font-semibold">Select Stream</label>
          <select
            value={selectedStream}
            onChange={(e) => setSelectedStream(e.target.value)}
            className="border p-2 rounded w-full"
          >
            <option value="">Select Stream</option>
            {streams.map((s) => (
              <option key={s.id} value={s.id}>
                {s.name}
              </option>
            ))}
          </select>
        </div>

        {/* Test Name */}
        <div>
          <label className="block mb-2 font-semibold">Test Name</label>
          <input
            type="text"
            placeholder="Enter test name"
            value={testName}
            onChange={(e) => setTestName(e.target.value)}
            className="border p-2 rounded w-full"
          />
        </div>

        {/* Duration */}
        <div>
          <label className="block mb-2 font-semibold">Duration (minutes)</label>
          <input
            type="number"
            min="10"
            value={duration}
            onChange={(e) => setDuration(e.target.value)}
            className="border p-2 rounded w-full"
          />
        </div>

        {/* Questions per level */}
        <div>
          <label className="block mb-2 font-semibold">
            No. of Questions per Level (Easy/Medium/Hard)
          </label>
          <input
            type="number"
            min="1"
            value={questionsPerLevel}
            onChange={(e) => setQuestionsPerLevel(e.target.value)}
            className="border p-2 rounded w-full"
          />
        </div>

        {/* Generate Button */}
        <button
          onClick={handleGenerate}
          disabled={loading}
          className={`w-full py-2 rounded text-white ${
            loading ? "bg-gray-500" : "bg-blue-600 hover:bg-blue-700"
          }`}
        >
          {loading ? "Generating..." : "Generate Balanced Test"}
        </button>

        {/* Result Section */}
        {result && (
          <div className="mt-6 p-4 border rounded bg-green-50">
            <h3 className="font-semibold text-green-700 mb-2">
              ✅ Test Created Successfully!
            </h3>
            <p>
              <strong>Test Name:</strong> {result.testName}
            </p>
            <p>
              <strong>Test ID:</strong> {result.test_id}
            </p>
            <p>
              <strong>Total Questions:</strong> {result.totalQuestions}
            </p>
            <p>
              <strong>Duration:</strong> {result.duration} mins
            </p>
          </div>
        )}
      </div>
    </div>
  );
}
