import React from 'react';
import './index.css'

import logo from '../../assets/logo-bg-white.png';

const Sidebar = () => {
    return (
        <div className="bg-white text-black w-64 h-screen">
            <div className="p-4">
            <div className="p-4 flex items-center">
                <img src={logo} alt="Logo" className="w-16 h-w-16 object-cover mr-2" />
                <h1 className="text-2xl font-bold primary-color">Recyclify</h1>
            </div>
                <ul className="mt-4">
                    <li className="py-2 px-4 dashboard-li">Dashboard</li>
                    <li className="py-2 px-4 dashboard-li">Users Information</li>
                    <li className="py-2 px-4 dashboard-li">Drivers Information</li> 
                </ul>
            </div>
        </div>
    );
};

export default Sidebar;
