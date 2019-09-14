<template>
  <div id='app'>
    <TheHeader v-bind:username="username" v-on:update-session="updateSession"/>
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
        username: this.username
      }
    },

    components: {
      TheHeader
    },

    mounted() {
      axios.get('/api/session')
        .then(response => {
          this.username = response.data.username
        })
    },

    beforeUpdate() {
      axios.get('/api/session')
        .then(response => {
          this.username = response.data.username
        })
    },

    methods: {
      updateSession() {
        this.username = null
      }
    }
  }
</script>

<style scoped>
</style>