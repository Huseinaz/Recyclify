import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faTrashAlt } from '@fortawesome/free-solid-svg-icons';

const DriversTable = () => {
    const [users, setUsers] = useState([]);
    const [isOpen, setIsOpen] = useState(false);
    const [loading, setLoading] = useState(true);

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
            setIsOpen(false);
            setFormData({
                first_name: '',
                last_name: '',
                email: '',
                password: ''
            });
            fetchUsers();
        } catch (error) {
            console.error('Error creating driver:', error.response.data.message);
        }
    };

    const togglePopup = () => {
        setIsOpen(!isOpen);
    };

    const handleClickOutside = (e) => {
        if (e.target.classList.contains('popup-overlay')) {
            setIsOpen(false);
        }
    };

    const fetchUsers = async () => {
        try {
            const response = await axios.get('http://localhost:8000/api/users/get', {
                headers: {
                    Authorization: `Bearer ${localStorage.getItem("token")}`,
                },
            });
            const filteredUsers = response.data.users.filter((user) => user.role_id === 3);
            setUsers(filteredUsers);
            setLoading(false);
        } catch (error) {
            console.error('Error fetching users:', error.response);
        }
    };

    useEffect(() => {
        fetchUsers();
    }, []);

    const handleActive = async (id) => {
        try {
            const response = await axios.post(`http://localhost:8000/api/users/${id}/activate`, {}, {
                headers: {
                    Authorization: `Bearer ${localStorage.getItem("token")}`,
                },
            });
            console.log('User activated:', response.data.message);
            fetchUsers();
        } catch (error) {
            console.error('Error activating user:', error.response.data.message);
        }
    };

    const handleShutDown = async (id) => {
        try {
            const response = await axios.post(`http://localhost:8000/api/users/${id}/shutdown`, {}, {
                headers: {
                    Authorization: `Bearer ${localStorage.getItem("token")}`,
                },
            });
            console.log('User shutdown:', response.data.message);
            fetchUsers();
        } catch (error) {
            console.error('Error shutting down user:', error.response.data.message);
        }
    };

    const handleDelete = async (id) => {
        try {
            const response = await axios.delete(`http://localhost:8000/api/users/${id}`, {
                headers: {
                    Authorization: `Bearer ${localStorage.getItem("token")}`,
                },
            });
            console.log('Branch deleted:', response.data.message);
            fetchUsers();
        } catch (error) {
            console.error('Error deleting branch:', error.response.data.message);
        }
    };

    return (
        <div>
            {loading ? (
                <div className="flex justify-center items-center h-screen">
                    <div className="loader"></div>
                </div>
            ) : (
                <div className="overflow-x-auto pl-8 pr-8">
                    <div className='flex justify-between mt-32 pb-3'>
                        <h1 className="text-xl font-bold">Drivers Information</h1>
                        <button className="primary-bg text-white font-bold py-2 px-4 rounded login-btn" onClick={togglePopup}>
                            Create Driver
                        </button>
                    </div>
                    {isOpen && (
                        <div className="fixed inset-0 z-50 flex justify-center items-center bg-black bg-opacity-50 popup-overlay" onClick={handleClickOutside}>
                            <div className="bg-white p-8 rounded shadow-lg">
                                <div className="flex justify-between items-center">
                                    <h1 className="text-2xl font-bold">Create Driver</h1>
                                    <button className="text-red text-2xl focus:outline-none" onClick={togglePopup}>×</button>
                                </div>
                                <hr className="my-4 border-white" />
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
                        </div>
                    )}
                    <table className="table-auto min-w-full border-collapse border-t border-b border-gray-200">
                        <thead>
                            <tr>
                                <th className="px-4 py-2 border-b border-gray-200 w-1/12">ID</th>
                                <th className="px-4 py-2 border-b border-gray-200 w-2/12">Name</th>
                                <th className="px-4 py-2 border-b border-gray-200 w-2/12">Email</th>
                                <th className="px-4 py-2 border-b border-gray-200 w-2/12">Status</th>
                                <th className="px-4 py-2 border-b border-gray-200 w-3/12">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            {users.map((user) => (
                                <tr key={user.id}>
                                    <td className="px-4 py-2 border-b border-gray-200 text-center">{user.id}</td>
                                    <td className="px-4 py-2 border-b border-gray-200 text-center">{user.first_name} {user.last_name}</td>
                                    <td className="px-4 py-2 border-b border-gray-200 text-center">{user.email}</td>
                                    <td className="px-4 py-2 border-b border-gray-200 text-center">{user.active === 1 ? <span>Active</span> : <span>Not Active</span>}</td>
                                    <td className="px-4 py-2 border-b border-gray-200 text-center">
                                        <button className="bg-green-500 hover:bg-green-600 text-white font-bold py-1 px-2 rounded mr-2" onClick={() => handleActive(user.id)}>
                                            Activate
                                        </button>
                                        <button className="bg-yellow-500 hover:bg-yellow-400 text-white font-bold py-1 px-2 rounded mr-2" onClick={() => handleShutDown(user.id)}>
                                            Deactivate
                                        </button>
                                        <button className="bg-red-500 hover:bg-red-600 text-white font-bold py-1 px-2 rounded" onClick={() => handleDelete(user.id)}>
                                            <FontAwesomeIcon icon={faTrashAlt} />
                                        </button>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            )}
        </div>
    );
};

export default DriversTable;
