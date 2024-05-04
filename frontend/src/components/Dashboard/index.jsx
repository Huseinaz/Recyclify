import React, { useEffect, useState } from 'react';
import axios from 'axios';

import driver from '../../assets/driver.png';
import user from '../../assets/user.png';

const Dashboard = () => {
    const [users, setUsers] = useState([]);
    const [userCount, setUserCount] = useState(0);
    const [driverCount, setDriverCount] = useState(0);
    const [loading, setLoading] = useState(true);

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
            setLoading(false);
        } catch (error) {
            console.error('Error fetching users:', error.response);
        }
    };

    useEffect(() => {
        fetchUsers();
    }, []);

    return (
        <div>
            {loading ? (
                <div className="flex justify-center items-center h-screen">
                    <div className="loader"></div>
                </div>

            ) : (<div className="overflow-x-auto pl-8 pr-8">
                <h1 className="text-xl font-bold pb-3 mt-32">Dashboard</h1>
                <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
                    <div className="bg-gradient-to-r from-primary-100 to-primary-200 rounded-lg shadow-md hover:shadow-xl border-2 border-primary-400">
                        <div className="flex items-center justify-center p-8">
                            <img src={user} alt="User" className="w-16 h-w-16 object-cover mr-2" />
                            <span className="text-primary-500 text-4xl font-bold">{userCount} Users</span>
                        </div>
                    </div>
                    <div className="bg-gradient-to-r from-primary-100 to-primary-200 rounded-lg shadow-md hover:shadow-xl border-2 border-primary-400">
                        <div className="flex items-center justify-center p-8">
                            <img src={driver} alt="Driver" className="w-16 h-w-16 object-cover mr-2" />
                            <span className="text-primary-500 text-4xl font-bold">{driverCount} Drivers</span>
                        </div>
                    </div>
                </div>
            </div>
            )}
        </div>
    );
};

export default Dashboard;
