import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';

import './index.css';
import logo from '../../assets/logo-bg-gray.png';

const LoginForm = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');

    const navigate = useNavigate();

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            const response = await axios.post('http://localhost:8000/api/login', {
                email,
                password,
            });
            if (response.status === 200) {
                const user = response.data.user;
                if (user.role_id === 1) {
                    localStorage.setItem('token', response.data.authorisation.token);
                    console.log(response.data);
                    navigate('/dashboard');
                } else {
                    throw new Error('Unauthorized access');
                }
            } else {
                throw new Error();
            }
        } catch (error) {
            setError('Wrong email or password');
        }
    };
    

    return (
        <div className="white flex items-center justify-center h-screen login-bg">
            <div className="gray-bg p-8 rounded-md shadow-lg max-w-xs w-full">
                <div className="flex justify-center mb-1">
                    <img src={logo} alt="Logo" className="w-32 h-32 object-cover" />
                </div>
                <h2 className="text-3xl font-bold text-center mb-10">Recyclify</h2>
                <form onSubmit={handleSubmit}>
                    <div className="mb-4">
                        <input
                            type="email"
                            id='email'
                            value={email}
                            className="form-input w-full px-4 py-2 border rounded-lg text-gray-700"
                            required
                            placeholder="example@gmail.com"
                            onChange={(e) => setEmail(e.target.value)}
                        />
                    </div>
                    <div className="mb-6">
                        <input
                            type="password"
                            value={password}
                            className="form-input w-full px-4 py-2 border rounded-lg text-gray-700"
                            required
                            placeholder="••••••••"
                            onChange={(e) => setPassword(e.target.value)}
                        />
                    </div>
                    <button
                        type="submit"
                        className="w-full primary-bg text-white px-4 py-2 rounded-lg mb-4 login-btn">
                        Log In
                    </button>
                </form>
            </div>
        </div>
    )
}

export default LoginForm;
