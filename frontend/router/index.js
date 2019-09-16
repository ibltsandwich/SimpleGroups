import Vue from 'vue'
import Router from 'vue-router'

import HomePage from '../components/HomePage'
import SessionForm from '../components/SessionForm'
import GroupsIndex from '../components/GroupsIndex'
import GroupItem from '../components/GroupItem'
import NewGroupForm from '../components/NewGroupForm'
import PostItem from '../components/PostItem'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/api/login',
      name: 'SessionForm',
      component: SessionForm
    },
    {
      path: '/api/register',
      name: 'SessionForm',
      component: SessionForm
    },
    {
      path: '/api/groups',
      name: 'GroupsIndex',
      component: GroupsIndex
    },
    {
      path: '/api/groups/new',
      name: 'NewGroupForm',
      component: NewGroupForm
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