import Vue from 'vue'
import Router from 'vue-router'

import HomePage from '../components/HomePage'
import GroupsIndex from '../components/GroupsIndex'
import GroupItem from '../components/GroupItem'
import PostItem from '../components/PostItem'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/api/groups',
      name: 'GroupsIndex',
      component: GroupsIndex
    },
    {
      path: '/api/groups/:groupId',
      name: 'GroupItem',
      component: GroupItem,
      props: true
    },
    {
      path: '/api/groups/:groupId/posts/:postId',
      name: 'PostItem',
      component: PostItem,
      props: true
    },
    {
      path: '/',
      name: 'HomePage',
      component: HomePage
    },
  ]
})