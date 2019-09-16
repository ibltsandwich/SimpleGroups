<template>
  <ul class="members-list">
    <li v-for="member in members" v-bind:key="member.id">
        {{ member.username }}
    </li>
  </ul>
</template>

<script>
  
</script>

<style>

</style>