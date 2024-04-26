import React, { useEffect, useState } from 'react';
import axios from 'axios';

const UsersTable = () => {
    const [users, setUsers] = useState([]);

    const fetchUsers = async () => {
        try {
            const response = await axios.get('http://localhost:8000/api/users/get', {
                headers: {
                    Authorization: `Bearer ${localStorage.getItem("token")}`,
                },
            });
            const filteredUsers = response.data.users.filter((user) => user.role_id === 2);
            setUsers(filteredUsers);
        } catch (error) {
            console.error('Error fetching users:', error.response);
        }
    };

    useEffect(() => {
        fetchUsers();
    }, []);

    const handleActive = async (id) => {
        try {
            const response = await axios.post(`http://localhost:8000/api/users/${id}/activate`, {
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

    return (
        <div className="overflow-x-auto">
            <h1 className="text-xl font-bold pb-3">Users Information</h1>
            <table className="table-auto min-w-full border-collapse border-t border-b border-gray-200">
                <thead>
                    <tr>
                        <th className="px-4 py-2 border-b border-gray-200 w-1/12">ID</th>
                        <th className="px-4 py-2 border-b border-gray-200 w-2/12">Name</th>
                        <th className="px-4 py-2 border-b border-gray-200 w-2/12">Email</th>
                        <th className="px-4 py-2 border-b border-gray-200 w-2/12">Lat</th>
                        <th className="px-4 py-2 border-b border-gray-200 w-2/12">Long</th>
                        <th className="px-4 py-2 border-b border-gray-200 w-3/12">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    {users.map((user) => (
                        <tr key={user.id}>
                            <td className="px-4 py-2 border-b border-gray-200 text-center">{user.id}</td>
                            <td className="px-4 py-2 border-b border-gray-200 text-center">{user.first_name} {user.last_name}</td>
                            <td className="px-4 py-2 border-b border-gray-200 text-center">{user.email}</td>
                            <td className="px-4 py-2 border-b border-gray-200 text-center">{user.latitude}</td>
                            <td className="px-4 py-2 border-b border-gray-200 text-center">{user.longitude}</td>
                            <td className="px-4 py-2 border-b border-gray-200 text-center">
                                <button className="bg-green-500 hover:bg-green-600 text-white font-bold py-1 px-2 rounded mr-2" onClick={() => handleActive(user.id)}>
                                    Activate
                                </button>
                                <button className="bg-yellow-500 hover:bg-yellow-400 text-white font-bold py-1 px-2 rounded">
                                    Shutdown
                                </button>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default UsersTable;
