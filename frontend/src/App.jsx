import React from 'react';
import { BrowserRouter, Routes, Route, useLocation } from "react-router-dom";
import './style/colors.css'

import AdminRoutes from "./components/ProtectedRoutes/AdminRoutes";

import LoginForm from './components/Authentication';
import Sidebar from './components/Sidebar';
import Dashboard from './components/Dashboard';
import UsersTable from './components/UsersTable';
import DriversTable from './components/DriversTable';

const AppContent = () => {
  const location = useLocation();
  return (
    <div className="app">
      {location.pathname !== "/" && <Sidebar />}
      <AdminRoutes>
        <Routes>
          <Route path="/" element={<LoginForm />} />
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path='/userstable' element={<UsersTable />} />
          <Route path='/driverstable' element={<DriversTable />} />
        </Routes>
      </AdminRoutes>
    </div>
  );
};

const App = () => {
  return (
    <BrowserRouter>
      <AppContent />
    </BrowserRouter>
  );
};

export default App;
