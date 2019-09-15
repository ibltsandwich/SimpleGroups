<template>
  <div class="post-item-container">
    <h1 class="post-title">{{ post.title }}</h1>
    <h3 class="post-user">submitted by {{ post.username }}</h3>
    <span class="comment-date">{{ new Date(post.created_at).toLocaleDateString() }}</span>
    <span class="comment-time">{{ new Date(post.created_at).toLocaleTimeString() }}</span>
    <p class="post-body">{{ post.body }}</p>

    <h2 id="comments-header">Comments</h2>
    <ul class="comments-list">
      <CommentItem v-for="comment in comments" v-bind:key="comment.id" v-bind:comment="comment"/>
    </ul>

    <section v-if="this.username">
      <form v-on:submit="submitComment(groupId, post.id, commentBody)">
        <textarea class="comment-input" v-model="commentBody" placeholder="Post A Comment"/>
        <input type="submit"/>
      </form>
    </section>
  </div>
</template>

<script>
  import axios from 'axios';
  import CommentItem from './CommentItem';

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

    components: {
      CommentItem
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
            this.comments.push(response.data)
            this.commentBody = ''
          })
      }
    }
  }
</script>

<style scoped>
  .post-item-container {
    font-size: 16px;
    padding: 50px;
  }

  .post-title {
    font-size: 30px;
    margin: 5px 0;
  }

  .post-user {
    font-weight: 600;
  }

  .post-body {
    padding: 20px;
    border: 1px dotted lightgray;
    margin: 10px 0;
  }

  #comments-header {
    font-size: 24px;
    margin: 20px 0;
  }

  .comments-list {

  }

  .comment-input {
    width: 400px;
    height: 100px;
    font-size: 14px;
    padding: 10px;
  }
</style>