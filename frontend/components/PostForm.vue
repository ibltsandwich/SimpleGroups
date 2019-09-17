<template>
  <div class="post-form-container">
    <form class="post-form" v-on:submit="submitPost">
      <label for="post-title" value="title">Title</label>
      <input class="post-input" id="post-title" type="text" v-model="postTitle" placeholder="Title of your post" required/>

      <label for="post-body" value="body">Post Content</label>
      <textarea class="post-input" id="post-body" v-model="postBody" placeholder="Write out your post here" required/>
      <button class="input-submit" type="submit">Submit Post</button>
    </form>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data() {
      return {
        postTitle: '',
        postBody: ''
      }
    },

    methods: {
      submitPost() {
        const groupId = this.$route.params.groupId
        const post = {title: this.postTitle, body: this.postBody}
        axios.post(`/api/groups/${groupId}/posts`, post)
          .then(response => {
            this.$router.push(`/api/groups/${groupId}/posts/${response.data.id}`)
          })
      }
    }
  }
</script>

<style scoped>
  .post-form-container {
    margin: 80px auto;
    width: 50%;
  }

  .post-form {
    display: flex;
    flex-direction: column;
  }

  .post-form label {
    margin: 10px 0;
    font-size: 24px;
  }

  .post-input {
    padding: 10px;
    border: 2px solid lightgray;
    outline: none;
    border-radius: 5px;
  }

  .post-input:focus {
    border: 2px solid #1551a5;
    background: #f3f3f3;
  }

  #post-title {
    font-size: 18px;
  }

  #post-body {
    font-size: 14px;
    height: 200px;
  }

  .input-submit {
    margin-top: 20px;
    background: #1551a5;
    color: white;
    font-size: 18px;
    font-weight: 600;
    padding: 10px;
    border-radius: 5px;
    outline: none;
  }

  .input-submit:hover {
    cursor: pointer;
    text-decoration: underline;
  }

</style>