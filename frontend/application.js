import Vue from 'vue'
import Router from './router/index.js'
import App from './components/App.vue'

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#app',
    router: Router,
    components: { App },
    template: '<App/>'
  })
})