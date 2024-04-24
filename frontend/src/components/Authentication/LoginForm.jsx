import React from 'react';
import './index.css';
import logo from '../../assets/logo-bg-gray.png';

const LoginForm = () => {
    return (
        <div className="white flex items-center justify-center h-screen login-bg">
            <div className="gray-bg p-8 rounded-md shadow-lg max-w-xs w-full">
                <div className="flex justify-center mb-1">
                    <img src={logo} alt="Logo" className="w-32 h-32 object-cover" />
                </div>
                <h2 className="text-3xl font-bold text-center mb-10">Recyclify</h2>
                <form>
                    <div className="mb-4">
                        <input type="email" id="email" className="form-input w-full px-4 py-2 border rounded-lg text-gray-700" required placeholder="example@gmail.com" />
                    </div>
                    <div className="mb-6">
                        <input type="password" id="password" className="form-input w-full px-4 py-2 border rounded-lg text-gray-700" required placeholder="••••••••" />
                    </div>
                    <button type="submit" className="w-full primary-bg text-white px-4 py-2 rounded-lg mb-4 login-btn">Log In</button>
                </form>
            </div>
        </div>
    )
}

export default LoginForm;
