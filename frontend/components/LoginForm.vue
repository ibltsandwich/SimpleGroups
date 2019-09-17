<template>
  <div class="login-form-container">
    <ul class="errors">
      <li v-for="(error, index) in errors" v-bind:key="index">{{ error }}</li>
    </ul>
    <form class="login-form" v-on:submit="login(username, password)">
      <label for="username">Username</label>
      <input class="login-input" id="username" v-model="username" placeholder="Username" required/>

      <label for="password">Password</label>
      <input class="login-input" id="password" v-model="password" type="password" placeholder="Password" required/>
      <button class="input-submit" type="submit">Log In</button>
    </form>
    <button id="demo-login" class="input-submit" v-on:click="demoLogin">Demo Login</button>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data() {
      return {
        username: '',
        password: '',
        errors: []
      }
    },
    
    mounted() {
      if (this.$session.exists()) {
        this.$router.push('/')
      }
    },

    methods: {
      login(username, password) {
        const user = {user: { username, password }}
        axios.post('/api/session', user)
          .then(response => {
            if (response.status === 200) {
              this.$session.start()
              this.$session.set('id', response.data.id)
              this.$session.set('username', response.data.username)
              this.$emit('session-update')
              this.$router.push(this.$router.back())
            }
          })
          .catch(errors => {
            this.errors = errors.response.data
          })
      },
      demoLogin() {
        const user = {user: { username: 'newuser', password: 'password' }}
        axios.post('/api/session', user)
          .then(response => {
            if (response.status === 200) {
              this.$session.start()
              this.$session.set('id', response.data.id)
              this.$session.set('username', response.data.username)
            }
            this.$emit('session-update')
            this.$router.back()
          })
      }
    }
  }
</script>

<style scoped>
  .login-form-container {
    margin: 80px auto;
    width: 50%;
  }

  .login-form {
    display: flex;
    flex-direction: column;
  }

  .login-form label {
    margin: 10px 0;
    font-size: 24px;
  }

  .login-input {
    padding: 10px;
    border: 2px solid lightgray;
    outline: none;
    border-radius: 5px;
    font-size: 14px;
  }

  .login-input:focus {
    border: 2px solid #1551a5;
    background: #f3f3f3;
  }

  .input-submit {
    margin-top: 20px;
    background: #1551a5;
    color: white;
    font-size: 18px;
    font-weight: 600;
    padding: 10px;
    border-radius: 5px;
    outline: none;
  }

  .input-submit:hover {
    cursor: pointer;
    text-decoration: underline;
  }

  #demo-login {
    width: 100%;
  }

  .errors {
    list-style: inside;
    text-align: center;
  }
</style>