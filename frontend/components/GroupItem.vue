<template>
  <div class="group-item-container">
    <h1>{{ group.name }}</h1>
    <ul>
      <li v-for="post in posts" v-bind:key="post.id">
        <router-link :to="{ name: 'PostItem', params: { groupId: group.id, postId: post.id }}">
          {{ post.title }}
        </router-link>
      </li>
    </ul>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    name: 'GroupItem',
    data() {
      return {
        group: this.group || {},
        posts: this.posts || []
      }
    },

    created() {
      axios.get(`api/groups/${this.$route.params.groupId}`)
        .then(response => {
          this.group = response.data.group
          this.posts = response.data.posts
        })
    }
  }
</script>

<style>

</style>