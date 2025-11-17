import React, { useEffect, useState } from "react";
import api from "../../api";

export default function TestSetsList() {
  const [tests, setTests] = useState([]);
  const [loading, setLoading] = useState(true);
  const [selectedSet, setSelectedSet] = useState(null);
  const [questions, setQuestions] = useState([]);
  const [loadingQuestions, setLoadingQuestions] = useState(false);

  useEffect(() => {
    fetchTests();
  }, []);

  const fetchTests = async () => {
    try {
      const res = await api.get("/admin/tests/list");
      setTests(res.data || []);
    } catch (err) {
      console.error("Error fetching tests:", err);
      alert("Failed to load test sets");
    } finally {
      setLoading(false);
    }
  };

  const viewQuestions = async (setId, setName) => {
    setSelectedSet({ id: setId, name: setName });
    setLoadingQuestions(true);
    try {
      const res = await api.get(`/admin/tests/set/${setId}/questions`);
      setQuestions(res.data || []);
    } catch (err) {
      console.error("Error loading questions:", err);
      alert("Failed to load questions for this set");
    } finally {
      setLoadingQuestions(false);
    }
  };

  const closeModal = () => {
    setSelectedSet(null);
    setQuestions([]);
  };

  if (loading) return <div className="p-6 text-gray-600">Loading...</div>;

  return (
    <div className="p-6">
      <div className="flex justify-between items-center mb-4">
        <h2 className="text-2xl font-bold">📋 All Test Sets</h2>
        <button
          onClick={fetchTests}
          className="px-3 py-1 bg-blue-500 text-white rounded hover:bg-blue-600"
        >
          🔄 Refresh
        </button>
      </div>

      <div className="overflow-x-auto border rounded-lg shadow-md">
        <table className="w-full border-collapse">
          <thead className="bg-gray-200">
            <tr>
              <th className="p-2">Test ID</th>
              <th className="p-2">Test Name</th>
              <th className="p-2">Stream</th>
              <th className="p-2">Duration (min)</th>
              <th className="p-2">Set Name</th>
              <th className="p-2">Total Questions</th>
              <th className="p-2">Action</th>
            </tr>
          </thead>
          <tbody>
            {tests.length > 0 ? (
              tests.map((t) => (
                <tr key={t.set_id} className="border-b hover:bg-gray-50">
                  <td className="p-2 text-center">{t.test_id}</td>
                  <td className="p-2">{t.test_name}</td>
                  <td className="p-2">{t.stream_name || "—"}</td>
                  <td className="p-2 text-center">{t.total_duration}</td>
                  <td className="p-2 text-center font-semibold">{t.set_name}</td>
                  <td className="p-2 text-center">{t.total_questions}</td>
                  <td className="p-2 text-center">
                    <button
                      onClick={() => viewQuestions(t.set_id, t.set_name)}
                      className="px-2 py-1 text-sm bg-green-500 text-white rounded hover:bg-green-600"
                    >
                      👁 View
                    </button>
                  </td>
                </tr>
              ))
            ) : (
              <tr>
                <td colSpan="7" className="p-4 text-center text-gray-500">
                  No tests created yet.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      {/* Modal */}
      {selectedSet && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
          <div className="bg-white p-6 rounded-lg w-11/12 md:w-3/4 shadow-lg max-h-[80vh] overflow-y-auto">
            <div className="flex justify-between items-center mb-4">
              <h3 className="text-xl font-bold">
                Questions in Set: {selectedSet.name}
              </h3>
              <button
                onClick={closeModal}
                className="text-red-500 hover:text-red-700 font-semibold"
              >
                ✖ Close
              </button>
            </div>

            {loadingQuestions ? (
              <div className="text-gray-600">Loading questions...</div>
            ) : questions.length > 0 ? (
              <table className="w-full border border-gray-200">
                <thead className="bg-gray-100">
                  <tr>
                    <th className="p-2 text-left">#</th>
                    <th className="p-2 text-left">Question</th>
                    <th className="p-2">Level</th>
                    <th className="p-2">Chapter</th>
                    <th className="p-2">Subject</th>
                  </tr>
                </thead>
                <tbody>
                  {questions.map((q, i) => (
                    <tr key={q.question_id} className="border-b">
                      <td className="p-2 text-center">{i + 1}</td>
                      <td className="p-2">{q.question_text}</td>
                      <td className="p-2 text-center">{q.level}</td>
                      <td className="p-2 text-center">{q.chapter_name || "—"}</td>
                      <td className="p-2 text-center">{q.subject_name || "—"}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            ) : (
              <div className="text-gray-500">No questions found for this set.</div>
            )}
          </div>
        </div>
      )}
    </div>
  );
}
