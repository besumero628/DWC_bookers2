# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |n|
  User.create!(
    email: "example#{n+1}@example.com",
    password: 'password',
    name: "example#{n+1}",
    #confirmed_at: Time.now
    )
end

users = User.all

50.times do |n|
  m = users.sample
  Book.create!(
    user_id: m.id,
    title: "test title#{n+1}",
    body: "this book created by #{m.name}",
    rate: rand(1..5),
    category: "test#{50 % (n+1)}",
    created_at: rand(1..10).days.ago
  )
end

books = Book.all

users.each do |follow_user|
  users.each do |followed_user|
    follow_flag = (rand(1..2) == 1 ? true : false)
    if follow_flag
      Relationship.create!(
        follower_id: follow_user.id,
        followed_id: followed_user.id
      )
    end
  end
end

users.each do |user|
  books.each do |book|
    favorite_flag = (rand(1..2) == 1 ? true : false)
    if favorite_flag
      Favorite.create!(
        user_id: user.id,
        book_id: book.id
      )
    end
  end
end

5.times do |n|
  Group.create!(
    name: "Group#{n+1}",
    introduction: "this group is test sample",
    owner_id: users.sample.id
  )
end

