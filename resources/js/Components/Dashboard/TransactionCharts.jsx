import React from 'react';
import { Bar, Line, Pie } from 'react-chartjs-2';

const ReactApexChart = React.lazy(() => import("react-apexcharts"));

const TransactionCharts = ({ dailyTransactions, monthlyTransactions, yearlyTransactions }) => {
  // Pastikan data adalah array    
  const dailyData = Array.isArray(dailyTransactions) ? dailyTransactions : [];
  const monthlyData = Array.isArray(monthlyTransactions) ? monthlyTransactions : [];
  const yearlyData = Array.isArray(yearlyTransactions) ? yearlyTransactions : [];

  const state = {

    series: [{
      name: 'Daily Data',
      data: dailyData?.map(data => data.count)
    },],
    options: {
      chart: {
        type: 'bar',
        height: 350
      },
      plotOptions: {
        bar: {
          horizontal: false,
          columnWidth: '55%',
          borderRadius: 5,
          borderRadiusApplication: 'end'
        },
      },
      dataLabels: {
        enabled: false
      },
      stroke: {
        show: true,
        width: 2,
        colors: ['transparent']
      },
      xaxis: {
        categories: dailyData?.map(data => data.date),
      },
      yaxis: {
        title: {
          text: '$ (thousands)'
        }
      },
      fill: {
        opacity: 1
      },
      tooltip: {
        y: {
          formatter: function (val) {
            return "$ " + val + " thousands"
          }
        }
      }
    },


  }

  const dailyChartData = {
    labels: dailyData?.map(item => item.date),
    datasets: [
      {
        label: 'Daily Transactions',
        data: dailyData?.map(item => item.count),
        backgroundColor: 'rgba(75, 192, 192, 0.6)',
      },
    ],
  };

  const monthlyChartData = {
    labels: monthlyData?.map(item => item.month),
    datasets: [
      {
        label: 'Monthly Transactions',
        data: monthlyData?.map(item => item.count),
        backgroundColor: 'rgba(153, 102, 255, 0.6)',
      },
    ],
  };

  const yearlyChartData = {
    labels: yearlyData?.map(item => item.year),
    datasets: [
      {
        label: 'Yearly Transactions',
        data: yearlyData?.map(item => item.count),
        backgroundColor: 'rgba(255, 159, 64, 0.6)',
      },
    ],
  };

  return (
    <div>
      <h2 class="text-black">Transaction Charts</h2>
      <div className="chart-container">
        <h3 class="text-black">Daily Transactions</h3>
        <div>
          <ReactApexChart options={state.options} series={state.series} type="bar" height={350} />
        </div>
        {/* <h3>Monthly Transactions</h3>    
                <Line data={monthlyChartData} />    
                <h3>Yearly Transactions</h3>    
                <Pie data={yearlyChartData} />     */}
      </div>
    </div>
  );
};

export default TransactionCharts;    
