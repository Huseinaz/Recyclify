import React, { useState } from 'react';
import './index.css';

import logo from '../../assets/logo-bg-white.png';

const Sidebar = () => {
    const [selectedItem, setSelectedItem] = useState(null);

    const handleItemClick = (item) => {
        setSelectedItem(item);
    };

    return (
        <div className="bg-white text-black w-64 h-screen">
            <div className="p-4">
                <div className="p-4 flex items-center">
                    <img src={logo} alt="Logo" className="w-16 h-w-16 object-cover mr-2" />
                    <h1 className="text-2xl font-bold primary-color">Recyclify</h1>
                </div>
                <ul className="mt-4">
                    <li
                        className={`py-2 px-4 dashboard-li ${selectedItem === 'Dashboard' ? 'selected' : ''}`}
                        onClick={() => handleItemClick('Dashboard')}
                    >
                        Dashboard
                    </li>
                    <li
                        className={`py-2 px-4 dashboard-li ${selectedItem === 'Users Information' ? 'selected' : ''}`}
                        onClick={() => handleItemClick('Users Information')}
                    >
                        Users Information
                    </li>
                    <li
                        className={`py-2 px-4 dashboard-li ${selectedItem === 'Drivers Information' ? 'selected' : ''}`}
                        onClick={() => handleItemClick('Drivers Information')}
                    >
                        Drivers Information
                    </li>
                    <li
                        className={`py-2 px-4 dashboard-li ${selectedItem === 'Create Driver' ? 'selected' : ''}`}
                        onClick={() => handleItemClick('Create Driver')}
                    >
                        Create Driver
                    </li>
                    <li className="py-2 px-4 dashboard-li">
                        Logout
                    </li>
                </ul>
            </div>
        </div>
    );
};

export default Sidebar;
