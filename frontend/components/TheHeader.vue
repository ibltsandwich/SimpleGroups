<template>
  <header class="header-container">
    <section class="logo">
      <router-link to="/">
        {{ siteName }}
      </router-link>
    </section>

    <section class="nav-links">
      <ul class="nav-links-list flex">
        <li><router-link to="/api/groups">Groups</router-link></li>
        <section v-if="this.$attrs.sessionExists" class="flex session-links">
          <li>
            <router-link :to="`/api/users/${this.$session.get('id')}`">
              {{ this.$attrs.username }}
            </router-link>
          </li>
          <li v-on:click="logout" class="logout-button">Log out</li>
        </section>
        <section v-else class="flex session-links">
          <li>
            <router-link :to="'/api/login'" v-on:click="showLogin">
              Log In
            </router-link>
          </li>
          <li>
            <router-link :to="'/api/register'" v-on:click="showRegister">
              Register
            </router-link>
          </li>
        </section>
      </ul>
    </section>
  </header>
</template>

<script>
  import axios from 'axios';

  export default {
    name: 'TheHeader',
    props: ['session-exists, username'],
    data() {
      return {
        siteName: "Simple Groups",
        login: false,
        register: false
      }
    },

    methods: {
      logout() {
        axios.delete('api/session')
          .then(response => {
            this.$session.destroy()
            this.$emit('session-update')
            this.$router.push('/')
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
  @import url('https://fonts.googleapis.com/css?family=Berkshire+Swash&display=swap');

  header {
    height: 100px;
    width: 100%;
    background: #1551a5;
    color: white;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
  }

  .logo {
    font-family: 'Berkshire Swash';
    font-size: 24px;
    margin: auto 40px;
  }

  .logo a {
    color: white;
    text-decoration: none;
  }

  .nav-links {
    margin: auto 30px;
  }

  .nav-links a {
    color: white;
    text-decoration: none;
  }

  .nav-links a:hover {
    text-decoration: underline;
  }

  .logout-button:hover {
    cursor: pointer;
    text-decoration: underline;
  }

  .flex {
    display: flex;
    flex-direction: row;
  }

  .flex li {
    margin: 20px;
  }
</style>