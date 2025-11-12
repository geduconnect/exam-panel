import React, { useState, useEffect } from "react";
import api from "../api";

export default function TestSetGenerator() {
  const [tests, setTests] = useState([]);
  const [selectedTest, setSelectedTest] = useState("");
  const [numSets, setNumSets] = useState(3);

  useEffect(() => {
    api.get("/api/tests").then(res => setTests(res.data));
  }, []);

  const handleGenerate = async () => {
    if (!selectedTest) return alert("Please select a test");
    await api.post("/api/tests/generateSets", {
      test_id: selectedTest,
      num_sets: numSets
    });
    alert("✅ Test sets generated successfully!");
  };

  return (
    <div className="container mt-5">
      <h3>Generate Question Paper Sets</h3>
      <div className="row mt-3">
        <div className="col-md-6">
          <label>Select Test</label>
          <select className="form-select" onChange={(e) => setSelectedTest(e.target.value)}>
            <option value="">Select</option>
            {tests.map(t => (
              <option key={t.id} value={t.id}>{t.title}</option>
            ))}
          </select>
        </div>
        <div className="col-md-3">
          <label>No. of Sets</label>
          <input
            type="number"
            className="form-control"
            value={numSets}
            onChange={(e) => setNumSets(e.target.value)}
          />
        </div>
        <div className="col-md-3 d-flex align-items-end">
          <button onClick={handleGenerate} className="btn btn-primary w-100">Generate Sets</button>
        </div>
      </div>
    </div>
  );
}
