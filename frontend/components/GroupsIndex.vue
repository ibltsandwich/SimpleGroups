<template>
  <ul class="groups-list">
    <li v-for="group in groups" v-bind:key="group.id">
      <router-link :to="{ name: 'GroupItem', params: { groupId: group.id, group: group }}">
        {{ group.name }}
      </router-link>
    </li>
  </ul>
</template>

<script>
  import axios from 'axios';
  
  export default {
    data() {
      return {
        groups: this.groups
      }
    },

    created() {
      axios.get(`api/groups`)
        .then(response => {
          this.groups = response.data
        })
    }
  }
</script>

<style>
  .groups-list {
    height: 500px;
    width: 200px;
    margin: auto;
    background: red;
  }
</style>