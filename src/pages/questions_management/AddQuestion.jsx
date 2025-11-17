import React, { useEffect, useState } from "react";
import api from "../../api";
import "./QuestionManager.css";

export default function AddQuestion() {
  const [streams, setStreams] = useState([]);
  const [subjects, setSubjects] = useState([]);
  const [categories, setCategories] = useState([]);
  const [chapters, setChapters] = useState([]);
  const [subcategories, setSubcategories] = useState([]);

  const [selectedStream, setSelectedStream] = useState("");
  const [selectedSubject, setSelectedSubject] = useState("");
  const [selectedCategory, setSelectedCategory] = useState("");
  const [selectedChapter, setSelectedChapter] = useState("");
  const [selectedSubCategory, setSelectedSubCategory] = useState("");

  const [questionData, setQuestionData] = useState({
    question: "",
    option_a: "",
    option_b: "",
    option_c: "",
    option_d: "",
    correct_answer: "",
    explanation: "",
    level: "",
  });

  const [images, setImages] = useState({
    question_image: null,
    option_a_image: null,
    option_b_image: null,
    option_c_image: null,
    option_d_image: null,
  });

  useEffect(() => {
    fetchStreams();
  }, []);

  const fetchStreams = async () => {
    const res = await api.get("/admin/streams");
    setStreams(res.data);
  };

  const fetchSubjects = async (streamId) => {
    const res = await api.get(`/admin/subjects?stream_id=${streamId}`);
    setSubjects(res.data);
  };

  const fetchCategories = async (streamId, subjectId) => {
    const res = await api.get(
      `/admin/categories?stream_id=${streamId}&subject_id=${subjectId}`
    );
    setCategories(res.data);
  };

  const fetchChapters = async (categoryId) => {
    const res = await api.get(`/admin/chapters?category_id=${categoryId}`);
    setChapters(res.data);
  };

  const fetchSubCategories = async (chapterId) => {
    const res = await api.get(`/admin/subcategories?chapter_id=${chapterId}`);
    setSubcategories(res.data);
  };

  const handleStreamChange = (e) => {
    const id = e.target.value;
    setSelectedStream(id);
    setSelectedSubject("");
    setSelectedCategory("");
    setSelectedChapter("");
    setSelectedSubCategory("");
    setSubjects([]);
    setCategories([]);
    setChapters([]);
    setSubcategories([]);
    if (id) fetchSubjects(id);
  };

  const handleSubjectChange = (e) => {
    const id = e.target.value;
    setSelectedSubject(id);
    setSelectedCategory("");
    setSelectedChapter("");
    setSelectedSubCategory("");
    setCategories([]);
    setChapters([]);
    setSubcategories([]);
    if (id) fetchCategories(selectedStream, id);
  };

  const handleCategoryChange = (e) => {
    const id = e.target.value;
    setSelectedCategory(id);
    setSelectedChapter("");
    setSelectedSubCategory("");
    setChapters([]);
    setSubcategories([]);
    if (id) fetchChapters(id);
  };

  const handleChapterChange = (e) => {
    const id = e.target.value;
    setSelectedChapter(id);
    setSelectedSubCategory("");
    setSubcategories([]);
    if (id) fetchSubCategories(id);
  };

  const handleChange = (e) => {
    setQuestionData({ ...questionData, [e.target.name]: e.target.value });
  };

  const handleFileChange = (e) => {
    const { name, files } = e.target;
    setImages({ ...images, [name]: files[0] });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const formData = new FormData();

      Object.entries(questionData).forEach(([key, value]) =>
        formData.append(key, value)
      );

      Object.entries(images).forEach(([key, value]) => {
        if (value) formData.append(key, value);
      });

      formData.append("stream_id", selectedStream);
      formData.append("subject_id", selectedSubject);
      formData.append("category_id", selectedCategory || "");
      formData.append("chapter_id", selectedChapter);
      formData.append("subcategory_id", selectedSubCategory || "");

      await api.post("/admin/questions", formData, {
        headers: { "Content-Type": "multipart/form-data" },
      });

      alert("✅ Question added successfully!");

      setQuestionData({
        question: "",
        option_a: "",
        option_b: "",
        option_c: "",
        option_d: "",
        correct_answer: "",
        explanation: "",
        level: "",
      });

      setImages({
        question_image: null,
        option_a_image: null,
        option_b_image: null,
        option_c_image: null,
        option_d_image: null,
      });

      setSelectedStream("");
      setSelectedSubject("");
      setSelectedCategory("");
      setSelectedChapter("");
      setSelectedSubCategory("");
    } catch (err) {
      console.error("❌ Error adding question:", err);
      alert("Failed to add question");
    }
  };

  return (
    <div className="question-manager-container">
      <h2 className="text-2xl font-bold mb-6 text-center">➕ Add Question</h2>

      {/* Filters */}
      <div className="filter-bar">
        <select value={selectedStream} onChange={handleStreamChange}>
          <option value="">Select Stream</option>
          {streams.map((s) => (
            <option key={s.id} value={s.id}>{s.name}</option>
          ))}
        </select>

        <select value={selectedSubject} onChange={handleSubjectChange}>
          <option value="">Select Subject</option>
          {subjects.map((s) => (
            <option key={s.id} value={s.id}>{s.name}</option>
          ))}
        </select>

        <select value={selectedCategory} onChange={handleCategoryChange}>
          <option value="">Select Category</option>
          {categories.map((c) => (
            <option key={c.id} value={c.id}>{c.name}</option>
          ))}
        </select>

        <select value={selectedChapter} onChange={handleChapterChange}>
          <option value="">Select Chapter</option>
          {chapters.map((c) => (
            <option key={c.id} value={c.id}>{c.name}</option>
          ))}
        </select>

        <select
          value={selectedSubCategory}
          onChange={(e) => setSelectedSubCategory(e.target.value)}
        >
          <option value="">Select Sub Category</option>
          {subcategories.map((sc) => (
            <option key={sc.id} value={sc.id}>{sc.name}</option>
          ))}
        </select>
      </div>

      {/* Form */}
      <form onSubmit={handleSubmit} className="add-question-form">
        <textarea
          name="question"
          placeholder="Enter question"
          value={questionData.question}
          onChange={handleChange}
        />

        <input type="file" name="question_image" onChange={handleFileChange} />

        {["a", "b", "c", "d"].map((opt) => (
          <div key={opt}>
            <input
              name={`option_${opt}`}
              placeholder={`Option ${opt.toUpperCase()}`}
              value={questionData[`option_${opt}`]}
              onChange={handleChange}
            />
            <input
              type="file"
              name={`option_${opt}_image`}
              onChange={handleFileChange}
            />
          </div>
        ))}

        <input
          name="correct_answer"
          placeholder="Correct Answer"
          value={questionData.correct_answer}
          onChange={handleChange}
        />

        <textarea
          name="explanation"
          placeholder="Explanation"
          value={questionData.explanation}
          onChange={handleChange}
        />

        <select name="level" value={questionData.level} onChange={handleChange}>
          <option value="">Select Difficulty</option>
          <option value="easy">Easy</option>
          <option value="medium">Moderate</option>
          <option value="hard">Hard</option>
        </select>

        <button type="submit">Save Question</button>
      </form>
    </div>
  );
}
