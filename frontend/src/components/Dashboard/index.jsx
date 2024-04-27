import React, { useEffect, useState } from 'react';
import axios from 'axios';

const Dashboard = () => {
    const [users, setUsers] = useState([]);
    const [userCount, setUserCount] = useState(0);
    const [driverCount, setDriverCount] = useState(0);

    const fetchUsers = async () => {
        try {
            const response = await axios.get('http://localhost:8000/api/users/get', {
                headers: {
                    Authorization: `Bearer ${localStorage.getItem("token")}`,
                },
            });

            const allUsers = response.data.users;
            setUsers(allUsers);

            const userCount = allUsers.filter(user => user.role_id === 2).length;
            const driverCount = allUsers.filter(user => user.role_id === 3).length;
            setUserCount(userCount);
            setDriverCount(driverCount);
        } catch (error) {
            console.error('Error fetching users:', error.response);
        }
    };

    useEffect(() => {
        fetchUsers();
    }, []);

    return (
        <div className="overflow-x-auto pl-8 pr-8">
            <h1 className="text-xl font-bold pb-3 mt-32">Dashboard</h1>
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
                <div className="bg-gradient-to-r from-primary-100 to-primary-200 rounded-lg shadow-md p-8 flex flex-col items-center justify-center hover:shadow-lg">
                    <i className="fas fa-users text-primary-500 text-4xl mb-2"></i>
                    <span className="text-primary-500 text-4xl font-bold">{userCount}</span>
                    <p className="text-gray-700 mt-2 text-lg">Total Users</p>
                </div>
                <div className="bg-gradient-to-r from-primary-100 to-primary-200 rounded-lg shadow-md p-8 flex flex-col items-center justify-center hover:shadow-lg">
                    <i className="fas fa-users text-primary-500 text-4xl mb-2"></i>
                    <span className="text-primary-500 text-4xl font-bold">{driverCount}</span>
                    <p className="text-gray-700 mt-2 text-lg">Total Drivers</p>
                </div>
            </div>
        </div>
    );
};

export default Dashboard;
