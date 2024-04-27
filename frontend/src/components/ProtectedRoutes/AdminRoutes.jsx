import { useNavigate } from 'react-router-dom';
import { useEffect } from 'react';
import axios from 'axios';

const AdminRoutes = ({ children }) => {
    const navigate = useNavigate();

    const validate = async () => {
        try {
            const response = await axios.get('http://localhost:8000/api/users/get', {
                headers: {
                    Authorization: `Bearer ${localStorage.getItem("token")}`,
                },
            });
            if (response.data.user.role_id === 1) {
                console.log('User is an Admin');
            } else {
                navigate('/');
            }
        } catch (error) {
            navigate('/');
        }
    };

    useEffect(() => {
        validate();
    }, []);
    return children;
};

export default AdminRoutes;
