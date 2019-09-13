# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create({username: "NewUser1", email: "demo@demoman.com", password: "password"})
user2 = User.create({username: "NewUser2", email: "new@user.com", password: "password2"})

group1 = Group.create({name: "Rails Users", owner_id: 1})
group2 = Group.create({name: "Vue Users", owner_id: 1})
group3 = Group.create({name: "React Users", owner_id: 2})
group4 = Group.create({name: "Node Users", owner_id: 2})

post1 = Post.create({title: "New user here", body: "Hi, I'm new here!", user_id: 1, group_id: 1, username: "NewUser"})

comment1 = Comment.create({body: "I don't know how to edit my post", user_id: 1, post_id: 1, username: "NewUser"})