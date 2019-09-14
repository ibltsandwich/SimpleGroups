<template>
  <div class="group-item-container">
    <main class="main-group-section">
      <h1 id="group-name">{{ group.name }}</h1>
      <ul class="group-posts">
        <li v-for="post in posts" v-bind:key="post.id">
          <router-link :to="{ name: 'PostItem', params: { groupId: group.id, postId: post.id }}">
            {{ post.title }}
          </router-link>
          <br/>
          submitted by 
          <span id="submitted-user">{{ post.username }}</span> 
          on {{ new Date(post.created_at).toLocaleDateString() }} 
          at {{ new Date(post.created_at).toLocaleTimeString() }} 
        </li>
      </ul>
    </main>
    <section class="group-sidebar">
      <section v-if="members[userId]" class="group-buttons">
        <button v-on:click="leaveGroup(group.id)">Leave Group</button>
        <button>Create a post</button>
      </section>
      <section v-else-if="group.owner_id === userId">
        <button>Create a post</button>
      </section>
      <section v-else-if="userId" class="group-buttons">
          <button v-on:click="joinGroup(group.id, userId)">Join Group</button>
      </section>
      <h2>Owner</h2>
      <h3>{{ group.owner_name }}</h3>
      <ul class="members-list">
        <li v-for="member in members" v-bind:key="member.id">
            {{ member.username }}
        </li>
      </ul>
    </section>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    name: 'GroupItem',
    data() {
      return {
        group: this.group || {},
        posts: this.posts || [],
        members: this.members || {},
        username: this.username,
        userId: this.userId,
      }
    },

    created() {
      axios.get(`/api/groups/${this.$route.params.groupId}`)
        .then(response => {
          this.group = response.data.group
          this.posts = response.data.posts
          this.members = response.data.members
        })

      axios.get('/api/session')
        .then(response => {
          this.userId = response.data.id
          this.username = response.data.username
        })
    },

    methods: {
      joinGroup(groupId, userId) {
        axios.post(`/api/groups/${groupId}/memberships`)
          .then(response => {
            axios.get(`/api/groups/${this.$route.params.groupId}`)
              .then(response => {
                this.group = response.data.group
                this.posts = response.data.posts
                this.members = response.data.members
              })
          })
      },
      leaveGroup(groupId) {
        axios.delete(`api/groups/${groupId}/memberships/0`)
          .then(() => {
            axios.get(`/api/groups/${this.$route.params.groupId}`)
              .then(response => {
                this.group = response.data.group
                this.posts = response.data.posts
                this.members = response.data.members
              })
          })
      }
    }
  }
</script>

<style scoped>
  .group-item-container {
    position: relative;
    display: flex;
    flex-direction: row;
    justify-content: space-around;
    margin-top: 50px;
  }
  .main-group-section {

  }
  h2 {
    margin: 0;
  }
  h3 {
    margin: 0;
  }
  #submitted-user {
    font-weight: 700;
  }
  #group-name {
    margin: 0 0 20px 0;
  }
  .group-sidebar {

  }
  .members-list {
    padding: 0;
    list-style: none;
  }
</style>