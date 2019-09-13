<template>
  <h1>{{ group.name }}</h1>
</template>

<script>
  import axios from 'axios';

  export default {
    // props: ['group'],
    data() {
      return {
        group: this.group || {}
      }
    },

    created() {
      axios.get(`api/groups/${this.$route.params.groupId}`)
        .then(response => {
          this.group = response.data
        })
    }
  }
</script>

<style>

</style>