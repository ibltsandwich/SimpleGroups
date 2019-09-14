<template>
  <div class="login-form-container">
    <form v-on:submit="login(username, password)">
      <input v-model="username" placeholder="Username">
      <input v-model="password" type="password" placeholder="Password">
      <input type="submit" value="Log In">
    </form>
    <button v-on:click="demoLogin">Demo Login</button>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data() {
      return {
        username: '',
        password: ''
      }
    },
    
    methods: {
      login(username, password) {
        const user = {user: { username, password }}
        axios.post('api/session', user)
          .then(response => {
            this.$router.push({ name: 'HomePage' })
          })
      },
      demoLogin() {
        const user = {user: { username: 'NewUser1', password: 'password' }}
        axios.post('api/session', user)
          .then(response => {
            this.$router.push({ name: 'HomePage' })
          })
      }
    }
  }
</script>

<style>

</style>