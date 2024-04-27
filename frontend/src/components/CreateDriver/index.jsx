import React, { useState } from 'react';
import axios from 'axios';

const DriverForm = () => {
    const [formData, setFormData] = useState({
        first_name: '',
        last_name: '',
        email: '',
        password: ''
    });

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData({ ...formData, [name]: value });
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            const response = await axios.post('http://localhost:8000/api/createDriver', formData, {
                headers: {
                    Authorization: `Bearer ${localStorage.getItem("token")}`,
                },
            });
            console.log('Driver created:', response.data);
        } catch (error) {
            console.error('Error creating driver:', error.response.data.message);
        }
    };

    return (
        <div className="overflow-x-auto pl-8 pr-8">
            <h1 className="text-xl font-bold pb-3 mt-32">Create Driver</h1>
            <form onSubmit={handleSubmit} className="space-y-4">
                <div>
                    <input
                        type="text"
                        name="first_name"
                        value={formData.first_name}
                        onChange={handleChange}
                        className="w-80 px-4 py-2 rounded border focus:outline-none focus:border-lime-700"
                        placeholder="First Name"
                        required
                    />
                </div>
                <div>
                    <input
                        type="text"
                        name="last_name"
                        value={formData.last_name}
                        onChange={handleChange}
                        className="w-80 px-4 py-2 rounded border focus:outline-none focus:border-lime-700"
                        placeholder="Last Name"
                        required
                    />
                </div>
                <div>
                    <input
                        type="email"
                        name="email"
                        value={formData.email}
                        onChange={handleChange}
                        className="w-80 px-4 py-2 rounded border focus:outline-none focus:border-lime-700"
                        placeholder="Email"
                        required
                    />
                </div>
                <div>
                    <input
                        type="password"
                        name="password"
                        value={formData.password}
                        onChange={handleChange}
                        className="w-80 px-4 py-2 rounded border focus:outline-none focus:border-lime-700"
                        placeholder="Password"
                        required
                    />
                </div>
                <button type="submit" className="w-80 primary-bg text-white font-semibold py-2 rounded login-btn">
                    Create Driver
                </button>
            </form>
        </div>
    );
};

export default DriverForm;
