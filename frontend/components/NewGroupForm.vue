<template>
  <div class="group-form-container">
    <ul class="errors">
      <li v-for="(error, index) in errors" v-bind:key="index">{{ error }}</li>
    </ul>
    <form class="group-form" v-on:submit="submitGroup">
      <label for="group-name">Group Name</label>
      <input id="group-name" v-model="groupName" type="text" placeholder="Enter A Group Name" required>
      <button class="input-submit" type="submit">Create group</button>
    </form>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    name: 'NewGroupForm',
    data() {
      return {
        groupName: '',
        errors: ''
      }
    },
    methods: {
      submitGroup() {
        const group = { name: this.groupName }
        axios.post(`api/groups`, group)
          .then(response => {
            this.$router.push(`/api/groups/${response.data.id}`)
          })
          .catch(errors => {
            this.errors = errors.response.data
          })
      }
    }

  }
</script>

<style scoped>
  .group-form-container {
    margin: 80px auto;
    width: 50%;
  }

  .group-form {
    display: flex;
    flex-direction: column;
  }

  .group-form label {
    margin: 10px 0;
    font-size: 24px;
  }

  #group-name {
    padding: 10px;
    border: 2px solid lightgray;
    outline: none;
    border-radius: 5px;
    font-size: 18px;
  }

  #group-name:focus {
    border: 2px solid #1551a5;
    background: #f3f3f3;
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