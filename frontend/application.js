import Vue from 'vue'
import VueSession from 'vue-session'
import Router from './router/index.js'
import App from './components/App.vue'

Vue.use(VueSession)

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#app',
    router: Router,
    components: { App },
    template: '<App/>'
  })
})