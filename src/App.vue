<template>
  <h1>Weather Info</h1>
  <WeatherChart></WeatherChart>
</template>

<script>
import WeatherChart from './components/WeatherChart.vue';

export default {
  components: {
    WeatherChart,
  },
  metaInfo: {
    title: 'Weather info',
  },
};
</script>
