<template>
  <div class="login-form-container">
    <form v-on:submit="handleSubmit(username, email, password, password2, type)">
      <input v-model="username" placeholder="Username" />
      <input v-if="type==='register'" v-model="email" placeholder="Email" />
      <input v-model="password" type="password" placeholder="Password" />
      <input v-if="type==='register'" v-model="password2" type="password" placeholder="Input Password Again" />
      <input v-if="type==='register'" type="submit" value="Register" />
      <input v-else type="submit" value="Login" />
    </form>
    <button v-on:click="demoLogin">Demo Login</button>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data() {
      return {
        username: '',
        email: '',
        password: '',
        password2: '',
        type: this.$router.history.current.path.slice(5)
      }
    },

    methods: {
      handleSubmit(username, email, password, password2, type) {
        if (this.type === 'login') {
          const user = {user: { username, password }}
          axios.post('/api/session', user)
            .then(response => {
              if (response.status === 200) {
                this.$session.start()
                this.$session.set('id', response.data.id)
                this.$session.set('username', response.data.username)
              }
              this.$emit('update')
              this.$router.push(this.$router.back())
            })
        } else {
          if (password === password2) {
            const user = {user: { username, email, password }}
            axios.post('/api/users', user)
              .then(response => {
                if (response.status === 200) {
                  this.$session.start()
                  this.$session.set('id', response.data.id)
                  this.$session.set('username', response.data.username)
                }
                this.$emit('update')
                this.$router.back()
              })
          } else {
            // throw error message
          }
        }
      },
      demoLogin() {
        const user = {user: { username: 'newuser', password: 'password' }}
        axios.post('/api/session', user)
          .then(response => {
            if (response.status === 200) {
              this.$session.start()
              this.$session.set('id', response.data.id)
              this.$session.set('username', response.data.username)
            }
            this.$emit('update')
            this.$router.back()
          })
      }
    }
  }
</script>

<style>

</style>