<template>
  <header>
    <section class="logo">{{ siteName }}</section>
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
    background: black;
  }
  .logo {
    font-size: 16px;
  }
</style>