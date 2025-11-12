import React, { useState } from "react";
import { Link } from "react-router-dom";
import {
  ChevronDown,
  ChevronRight,
  Menu,
  X,
} from "lucide-react";
import "./Navbar.css"


export default function Sidebar({ isOpen, toggleSidebar }) {
  const [openHierarchy, setOpenHierarchy] = useState(false);
  const [openTests, setOpenTests] = useState(false);
  const [openReports, setOpenReports] = useState(false);
  const [openQuestions, setOpenQuestions] = useState(false);

  return (
    <>
      {/* Sidebar Toggle Button (visible only on mobile) */}
      <button className="sidebar-toggle" onClick={toggleSidebar}>
        {isOpen ? <X size={24} /> : <Menu size={24} />}
      </button>

      {/* Sidebar Container */}
      <div className={`sidebar ${isOpen ? "open" : "collapsed"}`}>

        <Link to="/admin-dashboard">Admin Dashboard</Link>
        {/* Hierarchy Manager */}
        <div>
          <div
            className="sidebar-section-header"
            onClick={() => setOpenHierarchy(!openHierarchy)}
          >
            <span>Hierarchy Manager</span>
            {openHierarchy ? <ChevronDown size={16} /> : <ChevronRight size={16} />}
          </div>
          {openHierarchy && (
            <ul className="sidebar-submenu">
              <li><Link to="/hierarchy/stream">Stream</Link></li>
              <li><Link to="/hierarchy/subject">Subject</Link></li>
              <li><Link to="/hierarchy/category">Category</Link></li>
              <li><Link to="/hierarchy/chapter">Chapter</Link></li>
              <li><Link to="/hierarchy/subcategory">Sub-Category</Link></li>
            </ul>
          )}
        </div>
        <div>
          <div
            className="sidebar-section-header"
            onClick={() => setOpenQuestions(!openQuestions)}
          >
            <span>Questions Management</span>
            {openQuestions ? <ChevronDown size={16} /> : <ChevronRight size={16} />}
          </div>
          {openQuestions && (
            <ul className="sidebar-submenu">
              <li><Link to="/questions/create" >Create Questions</Link></li>
              <li><Link to="/questions/questionsList" >Questions List</Link></li>
              <li><Link to="/questions" >Question Manager</Link></li>
            </ul>
          )}
        </div>
        {/* Tests Management */}
        <div>
          <div
            className="sidebar-section-header"
            onClick={() => setOpenTests(!openTests)}
          >
            <span>Tests Management</span>
            {openTests ? <ChevronDown size={16} /> : <ChevronRight size={16} />}
          </div>
          {openTests && (
            <ul className="sidebar-submenu">
              <li><Link to="/balancedtestscreator" >Balanced Tests Creator</Link></li>
              <li><Link to="/balancedtestslist" >Balanced Tests List</Link></li>
            </ul>
          )}
        </div>
        <div>
          <div
            className="sidebar-section-header"
            onClick={() => setOpenReports(!openReports)}
          >
            <span>Reports Management</span>
            {openReports ? <ChevronDown size={16} /> : <ChevronRight size={16} />}
          </div>
          {openReports && (
            <ul className="sidebar-submenu">
              <li><Link to="/admin/test-overview" >Overall Test Reports</Link></li>
            </ul>
          )}
        </div>

        {/* Questions Management */}



        <Link to="/dashboard">Users</Link>
        <Link to="/students">Students</Link>
      </div>
    </>
  );
}
