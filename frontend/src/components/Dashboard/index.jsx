import React, { useEffect, useState } from 'react';
import axios from 'axios';
import MyChart from '../MyChart'; // Import the Chart component
import Chart from '../Chart'; // Import the Chart component

import driver from '../../assets/driver.png';
import user from '../../assets/user.png';

const Dashboard = () => {
  const [users, setUsers] = useState([]);
  const [userCount, setUserCount] = useState(0);
  const [driverCount, setDriverCount] = useState(0);
  const [loading, setLoading] = useState(true);
  const [chartData, setChartData] = useState(null);

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

      // Prepare data for the chart
      const groupedData = allUsers.reduce((acc, user) => {
        const date = new Date(user.created_at).toLocaleDateString();
        if (!acc[date]) {
          acc[date] = { date, users: 0, drivers: 0 };
        }
        if (user.role_id === 2) {
          acc[date].users += 1;
        } else if (user.role_id === 3) {
          acc[date].drivers += 1;
        }
        return acc;
      }, {});

      const chartDataGrouped = Object.values(groupedData).map(entry => ({
        name: entry.date,
        users: entry.users,
        drivers: entry.drivers,
      }));

      const labels = allUsers.map(user => new Date(user.created_at).toLocaleDateString());
      const userData = allUsers.map(user => user.role_id === 2 ? 1 : 0);
      const driverData = allUsers.map(user => user.role_id === 3 ? 1 : 0);

      const chartDataIndividual = {
        labels,
        datasets: [
          {
            label: 'Users',
            data: userData,
            fill: false,
            borderColor: 'rgb(75, 192, 192)',
          },
          {
            label: 'Drivers',
            data: driverData,
            fill: false,
            borderColor: 'rgb(255, 99, 132)',
          },
        ],
      };

      setChartData({
        grouped: chartDataGrouped,
        individual: chartDataIndividual,
      });
      setLoading(false);
    } catch (error) {
      console.error('Error fetching users:', error.response);
    }
  };

  useEffect(() => {
    fetchUsers();
  }, []);

  const chartOptions = {
    responsive: true,
    plugins: {
      legend: {
        position: 'top',
      },
      title: {
        display: true,
        text: 'Users and Drivers Over Time',
      },
    },
  };

  return (
    <div>
      {loading ? (
        <div className="flex justify-center items-center h-screen">
          <div className="loader"></div>
        </div>
      ) : (
        <div className="overflow-x-auto pl-8 pr-8">
          <h1 className="text-xl font-bold pb-3 mt-28">Dashboard</h1>
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
            <div className="space-y-4">
              <div className="bg-gradient-to-r from-primary-100 to-primary-200 rounded-lg shadow-md hover:shadow-xl border-2 border-primary-400">
                <div className="flex items-center justify-center p-8">
                  <img src={user} alt="User" className="w-16 h-16 object-cover mr-2" />
                  <span className="text-primary-500 text-4xl font-bold">{userCount} Users</span>
                </div>
              </div>
              {chartData && (
                <div className="bg-white rounded-lg shadow-md p-4">
                  <MyChart data={chartData.grouped} />
                </div>
              )}
            </div>
            <div className="space-y-4">
              <div className="bg-gradient-to-r from-primary-100 to-primary-200 rounded-lg shadow-md hover:shadow-xl border-2 border-primary-400">
                <div className="flex items-center justify-center p-8">
                  <img src={driver} alt="Driver" className="w-16 h-16 object-cover mr-2" />
                  <span className="text-primary-500 text-4xl font-bold">{driverCount} Drivers</span>
                </div>
              </div>
              {chartData && (
                <div className="bg-white rounded-lg shadow-md p-4">
                  <Chart data={chartData.individual} options={chartOptions} className="w-full h-64" />
                </div>
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default Dashboard;
