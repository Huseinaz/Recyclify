import React from 'react'
import { Bar } from "react-chartjs-2";
import { Line } from 'react-chartjs-2';
import { Chart as Chart } from "chart.js/auto";
const EnrolledStudentsChart = ({ data, options,className  }) => {

    return (
        <div className={className}>
            <Line data={data} options={options} />
        </div>
    );
};

export default EnrolledStudentsChart