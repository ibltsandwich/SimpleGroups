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
      this.$session.start()
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