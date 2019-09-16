<template>
  <li class="comment-container">
    <div class="comment-info">
      <span class="comment-user">{{ comment.username }}</span>
      <section class="comment-info">
        <section class="comment-options" v-if="comment.user_id === this.$session.get('id')">
          <span v-on:click="editComment">edit</span>
          <span v-on:click="deleteComment">delete</span>
        </section>
        <section class="comment-timestamp">
          <span class="comment-date">{{ commentDate }}</span>
          <span class="comment-time">{{ commentTime }}</span>
        </section>
      </section>
    </div>
    <form v-if="editing" v-on:submit="submitEdit" class="comment-edit-form">
      <textarea v-model="commentBody" class="comment-edit-input" />
      <br/>
      <input type="submit">
      <button type="button" v-on:click="cancelEdit">Cancel</button>
    </form>
    <p class="comment-body" v-else>{{ commentBody }}</p>
  </li>

</template>

<script>
  import axios from 'axios';

  export default {
    props: ['comment'],

    data() {
      return {
        commentDate: new Date(this.comment.created_at).toLocaleDateString(),
        commentTime: new Date(this.comment.created_at).toLocaleTimeString(),
        editing: false,
        commentBody: this.comment.body
      }
    },

    methods: {
      editComment() {
        this.editing = true;
      },

      submitEdit() {
        const groupId = this.$route.params.groupId
        const postId = this.$route.params.postId
        const commentId = this.comment.id
        const comment = {body: this.commentBody}
        axios.patch(`/api/groups/${groupId}/posts/${postId}/comments/${commentId}`, comment)
          .then(response => {
            this.commentBody = response.data.body
            this.editing = false
          })
      },
      deleteComment() {
        this.$emit('delete-comment')
      },
      cancelEdit() {
        this.editing = false
      }
    }
  }
</script>

<style>
  .comment-body {
    border: 1px dotted lightgray;
    padding: 10px;
    margin: 10px 0;
  }
  .comment-user {
    font-size: 14px;
    font-weight: 600;
  }
  .comment-date {
    font-size: 14px;
  }
  .comment-time {
    font-size: 14px;
  }
  .comment-info {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
  }

  .comment-options span {
    margin: 0px 15px;
  }
  .comment-options span:hover {
    cursor: pointer;
    text-decoration: underline;
  }
  
  .comment-edit-form {
    margin-bottom: 10px;
  }

  .comment-edit-input {
    width: 500px;
    font-size: 14px;
    padding: 10px;
    margin: 10px 0;
    border: 1px dotted lightgray;
  }
</style>