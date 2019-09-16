<template>
  <div class="groups-index-container">
    <h1 class="groups-index-header">All Groups</h1>
    <ul class="groups-list">
      <li v-for="group in groups" v-bind:key="group.id">
        <router-link :to="{ name: 'GroupItem', params: { groupId: group.id }}">
          {{ group.name }}
        </router-link>
      </li>
      <li>
        <router-link to="/api/groups/new">Create new group</router-link>
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

<style>
  .groups-index-container {
    padding: 0 150px;
    margin-top: 50px;
  }

  .groups-index-header {
    font-size: 36px;
    margin-bottom: 20px;
  }

  .groups-list {
    height: 500px;
    width: 200px;
  }

  .groups-list li {
    margin: 5px 0;
  }
</style>