import React from 'react';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import LoginForm from './components/Authentication/LoginForm';

import './output.css';

const App = () => {
  return (
    <div className="app">
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<LoginForm />} />
        </Routes>
      </BrowserRouter>
    </div>
  )
}

export default App