import React from 'react';

const UsersTable = () => {
    return (
        <div className="overflow-x-auto">
            <h1 className="text-xl font-bold pb-3">Users Information</h1>
            <table className="table-auto min-w-full border-collapse border-t border-b border-gray-200">
                <thead>
                    <tr>
                        <th className="px-4 py-2 border-b border-gray-200 w-1/12">ID</th>
                        <th className="px-4 py-2 border-b border-gray-200 w-2/12">Name</th>
                        <th className="px-4 py-2 border-b border-gray-200 w-2/12">Email</th>
                        <th className="px-4 py-2 border-b border-gray-200 w-2/12">Phone</th>
                        <th className="px-4 py-2 border-b border-gray-200 w-2/12">Location</th>
                        <th className="px-4 py-2 border-b border-gray-200 w-3/12">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td className="px-4 py-2 border-b border-gray-200 text-center">1</td>
                        <td className="px-4 py-2 border-b border-gray-200 text-center">John Doe</td>
                        <td className="px-4 py-2 border-b border-gray-200 text-center">john@mail.com</td>
                        <td className="px-4 py-2 border-b border-gray-200 text-center">0123457</td>
                        <td className="px-4 py-2 border-b border-gray-200 text-center">Beirut</td>
                        <td className="px-4 py-2 border-b border-gray-200 text-center">
                            <button className="bg-green-500 hover:bg-green-600 text-white font-bold py-1 px-2 rounded mr-2">
                                Activate
                            </button>
                            <button className="bg-yellow-500 hover:bg-yellow-400 text-white font-bold py-1 px-2 rounded">
                                Shutdown
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    );
};

export default UsersTable;
