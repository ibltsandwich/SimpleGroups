# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create({ username: "newuser", email: "demo@demoman.com", password: "password" })
user2 = User.create({ username: "idk123", email: "idk@user.com", password: "password2" })
user3 = User.create({ username: "92837512", email: "928@37512.com", password: "123456789" })
user4 = User.create({ username: "nest0", email: "nest0@asd.com", password: "ernie213" })

group1 = Group.create({ name: "Rails Users", owner_id: 4, owner_name: 'nest0' })
group2 = Group.create({ name: "Vue Users", owner_id: 1, owner_name: 'newuser' })
group3 = Group.create({ name: "react users", owner_id: 2, owner_name: 'idk123' })
group4 = Group.create({ name: "node users", owner_id: 2, owner_name: 'idk123' })

membership1 = Membership.create({ user_id: 2, group_id: 1 })
membership2 = Membership.create({ user_id: 3, group_id: 1 })
membership3 = Membership.create({ user_id: 4, group_id: 1 })

post1 = Post.create({ title: "New user here", body: "Hi, I'm new here!", user_id: 1, group_id: 1, username: "newuser" })
post2 = Post.create({ title: "Project setup?", body: "I'm having some trouble setting up my project. anyone can help?", user_id: 3, group_id: 1, username: "92837512" })
post3 = Post.create({ title: "Rails Info", body: "Ruby on Rails, or Rails, is a server-side web application framework written in Ruby under the MIT License. Rails is a model–view–controller (MVC) framework, providing default structures for a database, a web service, and web pages. It encourages and facilitates the use of web standards such as JSON or XML for data transfer, HTML, CSS and JavaScript for user interfacing. In addition to MVC, Rails emphasizes the use of other well-known software engineering patterns and paradigms, including convention over configuration (CoC), don't repeat yourself (DRY), and the active record pattern.", user_id: 4, group_id: 1, username: "nest0" })

comment1 = Comment.create({ body: "I don't know how to edit my post", user_id: 1, post_id: 1, username: "NewUser" })
comment2 = Comment.create({ body: "jst click edit duh", user_id: 2, post_id: 1, username: "idk123" })
comment3 = Comment.create({ body: "wat u need", user_id: 2, post_id: 2, username: "idk123" })
