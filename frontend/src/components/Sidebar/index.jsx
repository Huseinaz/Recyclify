import React, { useState } from 'react';
import './index.css';

import logo from '../../assets/logo-bg-gray.png';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';

const Sidebar = () => {
    const [selectedItem, setSelectedItem] = useState('Dashboard');
    const navigate = useNavigate();

    const handleItemClick = (item) => {
        setSelectedItem(item);
    };

    const logOut = async () => {
        try {
            const response = await axios.post('http://localhost:8000/api/logout', null, {
                headers: {
                    Authorization: `Bearer ${localStorage.getItem("token")}`,
                },
            });
            if (response.status === 200) {
                localStorage.clear();
                navigate('/');
            } else {
                return;
            }
        } catch (error) {
            console.log(error.response.data.message);
        }
    };

    return (
        <div className="gray-bg text-black w-60 h-screen float-left">
            <div className="p-4">
                <div className="p-4 flex items-center">
                    <img src={logo} alt="Logo" className="w-16 h-w-16 object-cover mr-2" />
                    <h1 className="text-2xl font-bold primary-color">Recyclify</h1>
                </div>
                <ul className="mt-4">
                    <li
                        className={`py-2 px-4 dashboard-li ${selectedItem === 'Dashboard' ? 'selected' : ''}`}
                        onClick={() => {
                            handleItemClick('Dashboard');
                            navigate("/dashboard");
                        }}
                    >
                        Dashboard
                    </li>
                    <li
                        className={`py-2 px-4 dashboard-li ${selectedItem === 'Users Information' ? 'selected' : ''}`}
                        onClick={() => {
                            handleItemClick('Users Information');
                            navigate("/userstable");
                        }}
                    >
                        Users Information
                    </li>
                    <li
                        className={`py-2 px-4 dashboard-li ${selectedItem === 'Drivers Information' ? 'selected' : ''}`}
                        onClick={() => {
                            handleItemClick('Drivers Information');
                            navigate("/driverstable");
                        }}
                    >
                        Drivers Information
                    </li>
                </ul>
            </div>
            <div className="absolute bottom-0 w-full p-4 flex items-center">
                <ul>
                    <li className="py-2 px-4 dashboard-li" onClick={logOut}>
                        Logout
                    </li>
                </ul>
            </div>
        </div>
    );
};

export default Sidebar;
