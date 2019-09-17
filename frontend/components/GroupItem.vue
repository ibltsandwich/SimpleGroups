<template>
  <div class="group-item-container">

    <main class="main-group-section" v-if="joined">
      <h1 id="group-name">{{ group.name }}</h1>
      <h2 id="group-posts-header">Group Posts</h2>
      <ul class="group-posts">
        <li v-for="post in posts" v-bind:key="post.id">
          <router-link :to="{ name: 'PostItem', params: { groupId: group.id, postId: post.id }}">
            {{ post.title }}
          </router-link>
          <span class="post-info">
            submitted by 
            <span id="submitted-user">{{ post.username }}</span> 
            on {{ new Date(post.created_at).toLocaleDateString() }} 
            at {{ new Date(post.created_at).toLocaleTimeString() }} 
          </span>
        </li>
      </ul>
    </main>
    <main class="main-group-section" v-else>
      <h1>Join the group to see its posts</h1>
    </main>

    <section class="group-sidebar">

      <section v-if="this.$session.exists() && joined" class="group-buttons">
        <button class="button" v-on:click="leaveGroup(group.id)">Leave Group</button>
        <router-link class="button" :to="{ name: 'PostForm', params: { groupId: group.id }}">
          Create a post
        </router-link>
      </section>

      <section v-else-if="this.$session.exists() && group.owner_id === this.$session.get('id')" class="group-buttons">
        <router-link class="button" :to="{ name: 'PostForm', params: { groupId: group.id }}">
          Create a post
        </router-link>
      </section>

      <section v-else-if="this.$session.exists()" class="group-buttons">
        <button class="button" v-on:click="joinGroup(group.id)">Join Group</button>
      </section>

      <section v-else class="group-buttons">
        <router-link class="button" :to="{name: 'LoginForm'}">Log In To Continue</router-link>
      </section>

      <h2 class="header" id="owner-header">Group Owner</h2>
      <h3 id="owner-name">{{ group.owner_name }}</h3>

      <h3 class="header" id="members-header">Group Members</h3>
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
            this.members.push(response.data)
            this.joined = true
          })
      },
      leaveGroup(groupId) {
        const userId = this.$session.get('id')
        axios.delete(`api/groups/${groupId}/memberships/0`)
          .then(response => {
            this.members = response.data
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
    justify-content: space-around;
    margin: 50px 0;
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

  .group-posts li {
    display: grid;
    margin: 15px 0;
    font-size: 14px;
  }

  .group-posts li a {
    color: #1551a5;
    font-size: 18px;
  }

  .post-info {
    margin-top: 5px;
  }

  #submitted-user {
    font-weight: 700;
  }

  #group-name {
    margin: 0 0 20px 0;
  }

  .group-sidebar {
    border: 1px solid #1551a5;
    padding: 20px;
  }

  .group-buttons {
    display: flex;
    flex-direction: column;
  }

  .button {
    width: 150px;
    margin: 10px 0;
    padding: 10px 0;
    background: #1551a5;
    color: white;
    font-size: 18px;
    border-radius: 5px;
    font-weight: 700;
    outline: none;
    border: none;
  }

  .button:hover {
    text-decoration: underline;
  }

  .group-buttons a {
    text-align: center;
    text-decoration: none;
  }

  .group-buttons button:hover {
    cursor: pointer;
  }
  
  #owner-name {
    padding: 5px;
    margin-top: 5px;
    font-weight: 500;
  }

  .members-list {
    padding: 5px;
    list-style: none;
  }

  .members-list li {
    margin: 5px 0;
    font-size: 12px;
  }

  .header {
    font-size: 16px;
    margin: 5px 0;
  }
</style>