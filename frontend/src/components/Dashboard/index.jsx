import React from 'react';

const Dashboard = () => {
    const userCount = 100;

    return (
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
            <div className="bg-gradient-to-r from-primary-100 to-primary-200 rounded-lg shadow-md p-8 flex flex-col items-center justify-center hover:shadow-lg">
                <i className="fas fa-users text-primary-500 text-4xl mb-2"></i>
                <span className="text-primary-500 text-4xl font-bold">{userCount}</span>
                <p className="text-gray-700 mt-2 text-lg">Total Users</p>
                <div className="mt-4 flex justify-center">
                    <button className="px-4 py-2 bg-primary-200 text-primary-500 rounded-md hover:bg-primary-300 focus:outline-none">
                        View Details
                    </button>
                </div>
            </div>
        </div>

    );
};

export default Dashboard;
