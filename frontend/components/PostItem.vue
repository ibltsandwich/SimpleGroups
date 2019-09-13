<template>
  <div class="post-item-container">
    <h1>{{ post.title }}</h1>
    <p>{{ post.body }}</p>

    <h2>Comments</h2>
    <ul>
      <li v-for="comment in comments" v-bind:key="comment.id">
          {{ comment.body }}
      </li>
    </ul>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    name: 'PostItem',
    data() {
      return {
        groupId: this.$route.params.groupId,
        post: this.post || {},
        comments: this.comments || []
      }
    },

    created() {
      const routeParams = this.$route.params;
      axios.get(`api/groups/${routeParams.groupId}/posts/${routeParams.postId}`)
        .then(response => {
          this.post = response.data.post,
          this.comments = response.data.comments
        })
    }
  }
</script>

<style>

</style>