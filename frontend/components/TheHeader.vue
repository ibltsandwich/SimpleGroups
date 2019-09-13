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
      </ul>
    </section>
  </header>
</template>

<script>
  export default {
    data() {
      return {
        siteName: "Simple Groups"
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
</style>