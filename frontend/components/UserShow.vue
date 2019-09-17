<template>
  <div class="user-show-container">
    <h1 id="username">{{ username }}</h1>

    <h2 class="groups-header">Groups Owned</h2>
    <ul class="groups-list">
      <li v-for="(ownedGroup, index) in ownedGroups" v-bind:key="index">
        <router-link :to="{name: 'GroupItem', params: { groupId: ownedGroup.id }}"> 
          {{ ownedGroup.name }}
        </router-link>
      </li>
    </ul>

    <h2 class="groups-header">Groups Joined</h2>
    <ul class="groups-list">
      <li v-for="(group, index) in groups" v-bind:key="index">
        <router-link :to="{name: 'GroupItem', params: { groupId: group.id }}">
          {{ group.name }}
        </router-link>
      </li>
    </ul>
  </div>
</template>

<script>
  import axios from 'axios';
  
  export default {
    data() {
      return {
        username: '',
        groups: [],
        ownedGroups: []
      }
    },

    created() {
      axios.get(`/api/users/${this.$route.params.userId}`)
        .then(response => {
          this.username = response.data.username,
          this.groups = response.data.groups,
          this.ownedGroups = response.data.owned_groups
        })
    }
  }
</script>

<style scoped>
  .user-show-container {
    margin: 50px 150px;
  }

  #username {
    font-size: 36px;
    font-weight: 500;
  }

  .groups-header {
    margin: 10px 0;
    font-size: 24px;
  }

  .groups-list {
    font-size: 18px;
  }

  .groups-list li {
    margin: 10px 0;
  }
</style>