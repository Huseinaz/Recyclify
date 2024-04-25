import React from 'react';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import './style/colors.css'

import LoginForm from './components/Authentication';
import Sidebar from './components/Sidebar';
import Dashboard from './components/Dashboard';
import UsersTable from './components/UsersTable';
import DriversTable from './components/DriversTable';

const App = () => {
  return (
    <div className="app">
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<LoginForm />} />
          <Route path="/sidebar" element={<Sidebar />} />
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path='/userstable' element={<UsersTable />} />
          <Route path='/driverstable' element={<DriversTable />} />
        </Routes>
      </BrowserRouter>
    </div>
  )
}

export default App