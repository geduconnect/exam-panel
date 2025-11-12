import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import { useState } from "react";
import Dashboard from "./pages/Dashboard";
import AddUser from "./pages/AddUser";
import AdminStudents from "./pages/AdminStudents";
import Login from "./pages/Login";
import StreamTable from "./components/StreamTable";
import SubjectTable from "./components/SubjectTable";
import CategoryTable from "./components/CategoryTable";
import ChapterTable from "./components/ChapterTable";
import SubCategoryTable from "./components/SubCategoryTable";
import QuestionManager from "./pages/QuestionManager";
import TestCreator from "./pages/tests_manangement/TestCreator";
import TestManager from "./pages/tests_manangement/TestManager";
import TestSetsList from "./pages/tests_manangement/TestSetsList";
import AddQuestion from "./pages/questions_management/AddQuestion";
import QuestionList from "./pages/questions_management/QuestionList";
import AutoTestGenerator from "./pages/tests_manangement/AutoTestGenerator";
import AdminTestCreator from "./pages/AdminTestCreator";
import BalancedTestCreator from "./pages/BalancedTestCreator";
import AdminTestReport from "./pages/AdminTestReport";
import BalancedTestList from "./pages/BalancedTestList";
import BalancedTestView from "./pages/BalancedTestView";
import "./App.css";

import { useParams } from "react-router-dom";
import Navbar from "./components/Navbar";
import Sidebar from "./components/Sidebar";
import BalancedTestReport from "./pages/AdminTestReport";
import AdminTestOverview from "./pages/AdminTestOverview";
import AdminTestSummary from "./pages/AdminTestSummary";
import ExamAdminDashboard from "./pages/ExamAdminDashboard";


// ✅ Wrapper for dynamic test report route
function AdminTestReportWrapper() {
  const { testId } = useParams();
  return <BalancedTestReport testId={testId} />;
}

export default function App() {
  // Sidebar open/close state
  const [sidebarOpen, setSidebarOpen] = useState(true);

  const toggleSidebar = () => setSidebarOpen(!sidebarOpen);

  return (
    <Router>
      {/* Navbar */}
      <Navbar toggleSidebar={toggleSidebar} />

      {/* Layout with Sidebar + Content */}
      <div className="app-layout">
        <Sidebar isOpen={sidebarOpen} toggleSidebar={toggleSidebar} />

        {/* Main Content Area */}
        <main
          className="app-content"
          style={{
            marginLeft: sidebarOpen ? "250px" : "70px",
            marginTop: "60px",
            padding: "20px",
            transition: "margin-left 0.3s ease",
          }}
        >
          <Routes>
            {/* Login Route */}
            <Route path="/" element={<Login />} />

            {/* Dashboard + Other Pages */}
            <Route path="/dashboard" element={<Dashboard />} />
            <Route path="/add-user" element={<AddUser />} />
            <Route path="/students" element={<AdminStudents />} />

            {/* Hierarchy Management */}
            <Route path="/hierarchy/stream" element={<StreamTable />} />
            <Route path="/hierarchy/subject" element={<SubjectTable />} />
            <Route path="/hierarchy/category" element={<CategoryTable />} />
            <Route path="/hierarchy/chapter" element={<ChapterTable />} />
            <Route path="/hierarchy/subcategory" element={<SubCategoryTable />} />

            {/* Question Management */}
            <Route path="/questions" element={<QuestionManager />} />
            <Route path="/questions/create" element={<AddQuestion />} />
            <Route path="/questions/questionsList" element={<QuestionList />} />

            {/* Tests Management */}
            <Route path="/tests/create" element={<TestCreator />} />
            <Route path="/tests/testsList" element={<TestSetsList />} />
            <Route path="/testscreator" element={<AdminTestCreator />} />
            <Route path="/balancedtestscreator" element={<BalancedTestCreator />} />

            {/* Auto Test Generator */}
            <Route path="/exams" element={<AutoTestGenerator />} />

            {/* Balanced Tests */}
            <Route path="/balancedtestslist" element={<BalancedTestList />} />
            <Route path="/balancedtests/:id/view" element={<BalancedTestView />} />
            <Route
              path="/balancedtests/report/:testId"
              element={<BalancedTestReportWrapper />}
            />

            {/* Legacy or General Report */}
            <Route path="/balancedtests/report/:id" element={<BalancedTestReport />} />
            <Route path="/admin/test-overview" element={<AdminTestOverview />} />
            <Route path="/admin/test-summary/:test_id" element={<AdminTestSummary />} />
            <Route path="/admin-dashboard" element={<ExamAdminDashboard />} />


          </Routes>
        </main>
      </div>
    </Router>
  );
}

function BalancedTestReportWrapper() {
  const { testId } = useParams();
  return <BalancedTestReport testId={testId} />;
}