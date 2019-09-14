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
        <section v-if="username">
          <li>{{ username }}</li>
          <li v-on:click="logout" class="logout-button">Log out</li>
        </section>
        <section v-else>
          <li><router-link to="/login">Log In</router-link></li>
          <li><router-link to="/register">Register</router-link></li>
        </section>
      </ul>
    </section>
  </header>
</template>

<script>
  import axios from 'axios';

  export default {
    name: 'TheHeader',
    props: ['username'],
    data() {
      return {
        siteName: "Simple Groups"
      }
    },

    methods: {
      logout() {
        axios.delete('api/session')
          .then(response => {
            this.$emit('update-session')
          })
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