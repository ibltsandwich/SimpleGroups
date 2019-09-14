<template>
  <div class="post-item-container">
    <h1 class="post-title">{{ post.title }}</h1>
    <h3 class="post-user">submitted by {{ post.username }}</h3>
    <p class="post-body">{{ post.body }}</p>

    <h2 id="comments-header">Comments</h2>
    <ul class="comments-list">
      <li v-for="comment in comments" v-bind:key="comment.id">
          {{ comment.body }}
      </li>
    </ul>

    <section v-if="this.username">
      <form v-on:submit="submitComment(groupId, post.id, commentBody)">
        <input type="textarea" v-model="commentBody"/>
        <input type="submit"/>
      </form>
    </section>
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
        comments: this.comments || [],
        username: this.username,
        userId: this.userId,
        commentBody: ''
      }
    },

    created() {
      const routeParams = this.$route.params;
      axios.get(`api/groups/${routeParams.groupId}/posts/${routeParams.postId}`)
        .then(response => {
          this.post = response.data.post,
          this.comments = response.data.comments
        })

      axios.get('/api/session')
        .then(response => {
          this.username = response.data.username
          this.userId = response.data.userId
        })
    },

    methods: {
      submitComment(groupId, postId, commentBody) {
        const comment = {body: commentBody}
        axios.post(`/api/groups/${groupId}/posts/${postId}/comments`, comment)
          .then(response => {
            axios.get(`api/groups/${groupId}/posts/${postId}`)
              .then(response => {
                this.post = response.data.post,
                this.comments = response.data.comments
              })
            this.commentBody = ''
          })
      }
    }
  }
</script>

<style scoped>
  .post-item-container {
    padding: 50px;
  }

  .post-title {
    font-size: 30px;

  }

  .post-user {
    font-size: 14px;
  }

  .post-body {
    padding: 20px;
    border: 1px dotted gray;
    margin: 10px 0;
  }

  #comments-header {
    font-size: 24px;
  }

  .comments-list {
    margin: 10px 0;

  }
</style>