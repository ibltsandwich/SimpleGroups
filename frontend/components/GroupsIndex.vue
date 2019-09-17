<template>
  <div class="groups-index-container">
    <h1 class="groups-index-header">All Groups</h1>
    <router-link class="button" v-if="this.$session.exists()" to="/api/groups/new">Create new group</router-link>
    <ul class="groups-list">
      <li v-for="group in groups" v-bind:key="group.id">
        <router-link :to="{ name: 'GroupItem', params: { groupId: group.id }}">
          {{ group.name }}
        </router-link>
      </li>
    </ul>
  </div>
</template>

<script>
  import axios from 'axios';
  
  export default {
    name: 'GroupsIndex',
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

<style scoped>
  .groups-index-container {
    padding: 0 150px;
    margin-top: 50px;
  }

  .groups-index-header {
    font-size: 36px;
    margin-bottom: 30px;
  }

  .groups-list {
    margin: 30px 0;
  }

  .groups-list li{
    margin: 10px 0;
    font-size: 18px;
  }

  .groups-list li a {
    color: #1551a5;
    text-decoration: none;
  }

  .groups-list li a:hover {
    text-decoration: underline;
  }

  .button {
    width: 150px;
    padding: 10px;
    background: #1551a5;
    color: white;
    font-size: 18px;
    border-radius: 5px;
    font-weight: 700;
    outline: none;
    text-align: center;
    text-decoration: none;
    border: none;
  }

  .button:hover {
    text-decoration: underline;
  }
</style>