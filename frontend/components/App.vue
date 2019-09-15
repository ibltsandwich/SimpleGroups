<template>
  <div id='app'>
    <TheHeader />
    <router-view/>
  </div>
</template>

<script>
  import axios from 'axios';
  import TheHeader from './TheHeader';

  export default {
    name: 'App',

    components: {
      TheHeader
    }
  }
</script>

<style scoped>
</style>