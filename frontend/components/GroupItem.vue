<template>
  <div class="group-item-container">

    <main class="main-group-section">
      <h1 id="group-name">{{ group.name }}</h1>
      <h2 id="group-posts-header">Group Posts</h2>
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

      <section v-if="this.$session.exists() && joined" class="group-buttons">
        <button v-on:click="leaveGroup(group.id)">Leave Group</button>
        <button>Create a post</button>
      </section>

      <section v-else-if="group.owner_id === this.$session.get('id')">
        <button>Create a post</button>
      </section>

      <section v-else-if="this.$session.exists()" class="group-buttons">
          <button v-on:click="joinGroup(group.id)">Join Group</button>
      </section>

      <h2 id="owner-header">Owner</h2>
      <h3 id="owner-name">{{ group.owner_name }}</h3>

      <h3 id="members-header">Members</h3>
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
        members: this.members || [],
        joined: this.joined,
      }
    },

    created() {
      axios.get(`/api/groups/${this.$route.params.groupId}`)
        .then(response => {
          this.group = response.data.group
          this.posts = response.data.posts
          this.members = response.data.members
          this.joined = response.data.joined
        })
    },

    methods: {
      joinGroup(groupId) {
        axios.post(`/api/groups/${groupId}/memberships`)
          .then(response => {
            this.members[response.data.id] = response.data
            this.joined = true
          })
      },
      leaveGroup(groupId) {
        const userId = this.$session.get('id')
        axios.delete(`api/groups/${groupId}/memberships/0`)
          .then(response => {
            delete this.members[userId]
            this.joined = false
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
    justify-content: space-between;
    margin-top: 50px;
    padding: 0 150px;
  }

  .main-group-section {

  }

  #group-name {
    font-size: 36px;
  }
  
  #group-posts-header {
    font-size: 24px;
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
    padding: 5px;
    list-style: none;
    display: flex;
    flex-direction: column-reverse;
  }

  .members-list li {
    margin: 5px 0;
  }

  #members-header {
    font-size: 18px;
    margin: 10px 0;
  }
</style>