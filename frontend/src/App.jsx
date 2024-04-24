import React from 'react';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import LoginForm from './components/Authentication/LoginForm';
import Sidebar from './components/Sidebar';
import './style/colors.css'
import UsersTable from './components/UsersTable';

const App = () => {
  return (
    <div className="app">
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<LoginForm />} />
          <Route path="/sidebar" element={<Sidebar />} />
          <Route path='/userstable' element={<UsersTable />} />
        </Routes>
      </BrowserRouter>
    </div>
  )
}

export default App