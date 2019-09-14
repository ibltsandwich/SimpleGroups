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

    beforeUpdate() {
      axios.get('/api/session')
        .then(response => {
          this.username = response.data
        })
    },

    methods: {
      updateSession() {
        axios.get('/api/session')
          .then(response => {
            this.username = response.data
          })
      }
    }
  }
</script>

<style scoped>
</style>