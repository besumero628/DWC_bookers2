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

user = User.all

50.times do |n|
  m = user.sample
  Book.create!(
    user_id: m.id,
    title: "test title#{n+1}",
    body: "this book created by #{m.name}",
    rate: rand(1..5),
    category: "test#{50 % (n+1)}",
    created_at: rand(1..10).days.ago
  )
end

