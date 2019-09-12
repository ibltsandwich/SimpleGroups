# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

demo = User.create({username: "NewUser", email: "demo@demoman.com", password: "password"})

group1 = Group.create({name: "Rails Users", owner_id: 1})

post1 = Post.create({title: "New user here", body: "Hi, I'm new here!", user_id: 1, group_id: 1, username: "NewUser"})

comment1 = Comment.create({body: "I don't know how to edit my post", user_id: 1, post_id: 1, username: "NewUser"})