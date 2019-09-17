import Vue from 'vue'
import Router from 'vue-router'

import HomePage from '../components/HomePage'
import LoginForm from '../components/LoginForm'
import RegisterForm from '../components/RegisterForm'
import GroupsIndex from '../components/GroupsIndex'
import GroupItem from '../components/GroupItem'
import NewGroupForm from '../components/NewGroupForm'
import PostItem from '../components/PostItem'
import PostForm from '../components/PostForm'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/api/login',
      name: 'LoginForm',
      component: LoginForm
    },
    {
      path: '/api/register',
      name: 'RegisterForm',
      component: RegisterForm
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
      path: '/api/groups/:groupId/posts/new',
      name: 'PostForm',
      component: PostForm,
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