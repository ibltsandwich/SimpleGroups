<template>
  <div class="new-group-form-container">
    <form>
      <input v-model="groupName" type="text" placeholder="Enter A Group Name">
      <input v-on:click="submitGroup(groupName)" type="submit">
    </form>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    name: 'NewGroupForm',
    data() {
      return {
        groupName: ''
      }
    },
    methods: {
      submitGroup(groupName) {
        const group = { name: groupName }
        axios.post(`api/groups`, group)
          .then(response => {
            this.$router.push(`/api/groups/${response.data.id}`)
          })
      }
    }

  }
</script>

<style>

</style>