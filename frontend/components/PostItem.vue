<template>
  <div class="post-item-container">
    <router-link :to="{ path: `/api/groups/${this.$route.params.groupId}`}">
      {{ backButton }}
    </router-link>
    <section class="post-item">
      <h1 class="post-title">{{ post.title }}</h1>
      <h3 class="post-user">submitted by {{ post.username }}</h3>
      <div class="post-subheader">
        <section class="post-info">
          <span class="post-date">{{ postDate }}</span>
          <span class="post-time">{{ postTime }}</span>
        </section>
        <section v-if="deleting" class="post-options">
          Are you sure you want to delete this post?
          <span v-on:click="submitDelete">Yes</span>
          <span v-on:click="cancelDelete">No</span>
        </section>
        <section class="post-options" v-else-if="post.user_id === this.$session.get('id')">
          <span v-on:click="editPost">edit</span>
          <span v-on:click="deletePost">delete</span>
        </section>
      </div>
      <form v-if="editing" v-on:submit="submitEdit" class="post-edit-form">
        <textarea v-model="postBody" class="post-edit-input" />
        <br/>
        <input type="submit">
        <button type="button" v-on:click="cancelEdit">Cancel</button>
      </form>
      <p v-else class="post-body">{{ postBody }}</p>
    </section>

    <h2 id="comments-header">Comments</h2>
    <ul class="comments-list">
      <CommentItem v-for="comment in comments" v-bind:key="comment.id" v-bind:comment="comment" v-on:delete-comment="deleteComment(comment.id)"/>
    </ul>

    <section v-if="joined">
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
        backButton: '<< Back to group',
        groupId: this.$route.params.groupId,
        post: this.post || {},
        postBody: '',
        postDate: '',
        postTime: '',
        comments: this.comments || [],
        commentBody: '',
        joined: this.joined || false,
        editing: false,
        deleting: false
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
          this.postBody = this.post.body
          this.postDate = new Date(this.post.created_at).toLocaleDateString()
          this.postTime = new Date(this.post.created_at).toLocaleTimeString()
          this.comments = response.data.comments
        })

      if (this.$session.exists()) {
        axios.get(`/api/groups/${routeParams.groupId}`)
          .then(response => {
            this.joined = response.data.joined
          })
      }
    },

    methods: {
      submitComment(groupId, postId, commentBody) {
        const comment = {body: commentBody}
        axios.post(`/api/groups/${groupId}/posts/${postId}/comments`, comment)
          .then(response => {
            this.comments.push(response.data)
            this.commentBody = ''
          })
      },
      deleteComment(commentId) {
        const groupId = this.$route.params.groupId
        const postId = this.$route.params.postId
        axios.delete(`/api/groups/${groupId}/posts/${postId}/comments/${commentId}`)
          .then(response => {
            this.comments = response.data
          })
      },
      editPost() {
        this.editing = true
      },
      submitEdit() {
        const groupId = this.$route.params.groupId
        const postId = this.post.id
        const post = {body: this.postBody}
        axios.patch(`/api/groups/${groupId}/posts/${postId}`, post)
          .then(response => {
            this.postBody = response.data.body
            this.editing = false
          })
      },
      deletePost() {
        this.deleting = true
      },
      submitDelete() {
        const groupId = this.$route.params.groupId
        const postId = this.post.id
        axios.delete(`api/groups/${groupId}/posts/${postId}`)
          .then(() => {
            this.$router.push(`/api/groups/${groupId}`)
          })
      },
      cancelEdit() {
        this.editing = false
      },
      cancelDelete() {
        this.deleting = false
      }
    }
  }
</script>

<style scoped>
  .post-item-container {
    font-size: 16px;
    margin: 50px;
  }

  .post-item {
    position: relative;
  }

  .post-subheader {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
  }

  .post-title {
    font-size: 30px;
    margin: 5px 0;
  }

  .post-user {
    font-weight: 600;
  }

  .post-options span {
    font-size: 14px;
    margin: 0 10px;
  }

  .post-options span:hover {
    cursor: pointer;
    text-decoration: underline;
  }

  .post-body {
    padding: 20px;
    border: 1px dotted lightgray;
    margin: 10px 0;
  }

  .post-edit-form {
    margin-bottom: 10px;
  }

  .post-edit-input {
    width: 500px;
    font-size: 14px;
    padding: 10px;
    margin: 10px 0;
    border: 1px dotted lightgray;
  }

  #comments-header {
    font-size: 24px;
    margin: 20px 0;
  }

  .comment-input {
    width: 400px;
    height: 100px;
    font-size: 14px;
    padding: 10px;
  }
</style>