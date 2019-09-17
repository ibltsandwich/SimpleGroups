<template>
  <div class="register-form-container">
    <ul class="errors">
      <li v-for="(error, index) in errors" v-bind:key="index">{{ error }}</li>
    </ul>
    <form class="register-form" v-on:submit="register(username, email, password, password2)">
      <label for="username">Username</label>
      <input class="register-input" id="username" v-model="username" type="text" placeholder="Username" required/>

      <label for="email">Email</label>
      <input class="register-input" id="email" v-model="email" type="email" placeholder="Email" required/>

      <label for="password">Password</label>
      <input class="register-input" id="password" v-model="password" type="password" placeholder="Password" required/>

      <label for="password2">Confirm Password</label>
      <input class="register-input" id="password2" v-model="password2" type="password" placeholder="Input Password Again" required/>
      <button class="input-submit" type="submit">Register</button>
    </form>
    <button class="input-submit" id="demo-login" v-on:click="demoLogin">Demo Login</button>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data() {
      return {
        username: '',
        email: '',
        password: '',
        password2: '',
        errors: []
      }
    },
    
    mounted() {
      if (this.$session.exists()) {
        this.$router.push('/')
      }
    },

    methods: {
      register(username, email, password, password2) {
        if (password === password2) {
              const user = {user: { username, email, password }}
              axios.post('/api/users', user)
                .then(response => {
                  if (response.status === 200) {
                    this.$session.start()
                    this.$session.set('id', response.data.id)
                    this.$session.set('username', response.data.username)
                    this.$emit('session-update')
                    this.$router.back()
                  }
                })
                .catch(errors => {
                  this.errors = errors.response.data
                })
        } else {
          this.errors = ['Passwords must be the same']
        }
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

<style>
  .register-form-container {
    margin: 80px auto;
    width: 50%;
  }

  .register-form {
    display: flex;
    flex-direction: column;
  }

  .register-form label {
    margin: 10px 0;
    font-size: 24px;
  }

  .register-input {
    padding: 10px;
    border: 2px solid lightgray;
    outline: none;
    border-radius: 5px;
    font-size: 14px;
  }

  .register-input:focus {
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