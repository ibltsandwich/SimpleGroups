<template>
  <div id='app'>
    <TheHeader v-bind:sessionExists="sessionExists"/>
    <router-view/>
  </div>
</template>

<script>
  import axios from 'axios';
  import TheHeader from './TheHeader';

  export default {
    name: 'App',

    data() {
      return {
        sessionExists: this.$session.exists()
      }
    },

    components: {
      TheHeader
    }
  }
</script>

<style scoped>
</style>