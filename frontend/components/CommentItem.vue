<template>
  <li class="comment-container">
    <div class="comment-info">
      <span class="comment-user">{{ comment.username }}</span>
      <section class="comment-timestamp">
        <span class="comment-date">{{ commentDate }}</span>
        <span class="comment-time">{{ commentTime }}</span>
      </section>
    </div>
    <p class="comment-body">{{ comment.body }}</p>
  </li>

</template>

<script>
  export default {
    props: ['comment'],

    data() {
      return {
        commentDate: new Date(this.comment.created_at).toLocaleDateString(),
        commentTime: new Date(this.comment.created_at).toLocaleTimeString()
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
</style>