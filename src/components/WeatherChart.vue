<template>
  <div>
    <canvas ref="chart"></canvas>
  </div>
</template>

<script>
import { Chart, registerables } from 'chart.js';

export default {
  data() {
    return {
      chart: null,
    };
  },
  methods: {
    async fetchData() {
      try {
        const response = await fetch('http://localhost:8081/weather');
        if (!response.ok) throw new Error('Network response was not ok');
        const data = await response.json();
        this.setupChart(data);
      } catch (error) {
        console.error('There was a problem with your fetch operation:', error);
      }
    },
    setupChart(weatherData) {
      // Assuming the weatherData has a similar structure to what you've provided before
      const chartData = {
        labels: weatherData.hourly.time,
        datasets: [{
          label: 'Temperature (°C)',
          data: weatherData.hourly.temperature_2m,
          borderColor: 'rgb(255, 99, 132)',
          backgroundColor: 'rgba(255, 99, 132, 0.5)',
        }, {
          label: 'Wind Speed (km/h)',
          data: weatherData.hourly.wind_speed_10m,
          borderColor: 'rgb(54, 162, 235)',
          backgroundColor: 'rgba(54, 162, 235, 0.5)',
        }],
      };

      const chartOptions = {
        responsive: true,
        plugins: {
          legend: {
            position: 'top',
          },
          title: {
            display: true,
            text: 'Weather Data',
          },
        },
      };

      if (this.chart) {
        this.chart.destroy();
      }

      Chart.register(...registerables);
      this.chart = new Chart(this.$refs.chart, {
        type: 'line',
        data: chartData,
        options: chartOptions,
      });
    },
  },
  mounted() {
    this.fetchData();
  },
  beforeUnmount() {
    if (this.chart) {
      this.chart.destroy();
    }
  },
};
</script>
