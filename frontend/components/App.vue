<template>
  <div id='app'>
    <TheHeader v-bind:sessionExists="sessionExists" v-bind:username="username" v-on:session-update="sessionUpdate"/>
    <router-view v-on:session-update="sessionUpdate"/>
  </div>
</template>

<script>
  import axios from 'axios';
  import TheHeader from './TheHeader';

  export default {
    name: 'App',

    data() {
      return {
        sessionExists: this.$session.exists(),
        username: this.$session.get('username')
      }
    },

    components: {
      TheHeader
    },

    beforeCreate() {
      axios.get('/api/session')
        .then(response => {
          if (response.data.exists === true) {
            this.$session.start()
            this.$session.set('id', response.data.id)
            this.$session.set('username', response.data.username)
            this.sessionExists = this.$session.exists()
            this.username = this.$session.get('username')
          } else {
            this.$session.destroy()
          }
        })
    },

    methods: {
      sessionUpdate() {
        this.sessionExists = this.$session.exists()
        this.username = this.$session.get('username')
      }
    }
  }
</script>

<style scoped>
</style>