import axios from "axios";

const api = axios.create({
  baseURL: "http://localhost:5000", // backend base URL
  withCredentials: true, // ✅ allow session cookies
});

export default api;
