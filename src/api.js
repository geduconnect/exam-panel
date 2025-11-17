import axios from "axios";

const api = axios.create({
  baseURL: "http://localhost:5000",
  withCredentials: true, // ✅ send session cookie automatically
});

export default api;
