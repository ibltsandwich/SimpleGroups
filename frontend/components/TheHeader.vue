<template>
  <header>
    <section class="logo">
      <router-link to="/">
        {{ siteName }}
      </router-link>
    </section>

    <section class="nav-links">
      <ul>
        <li><router-link to="/api/groups">Groups</router-link></li>
        <section v-if="sessionExists">
          <li>{{ this.$session.get('username') }}</li>
          <li v-on:click="logout" class="logout-button">Log out</li>
        </section>
        <section v-else>
          <li><button v-on:click="showLogin">Log In</button></li>
          <li><button v-on:click="showRegister">Register</button></li>
        </section>
        <SessionForm v-if="login" type="login" v-on:update="update"/>
        <SessionForm v-else-if="register" type="register" v-on:update="update"/>
      </ul>
    </section>
  </header>
</template>

<script>
  import axios from 'axios';
  import SessionForm from './SessionForm';

  export default {
    name: 'TheHeader',
    data() {
      return {
        siteName: "Simple Groups",
        sessionExists: this.$session.exists(),
        login: false,
        register: false
      }
    },

    components: {
      SessionForm
    },

    methods: {
      logout() {
        axios.delete('api/session')
          .then(response => {
            this.$session.destroy()
            this.sessionExists = this.$session.exists()
          })
      },
      showLogin() {
        this.register = false
        this.login = true
      },
      showRegister() {
        this.login = false
        this.register = true
      },
      update() {
        this.login = false
        this.register = false
        this.sessionExists = this.$session.exists()
      }
    }
  }
</script>

<style scoped>
  header {
    height: 100px;
    width: 100%;
    background: lightgray;
  }
  .logo {
    font-size: 16px;
  }
  .logout-button:hover {
    cursor: pointer;
  }
</style>