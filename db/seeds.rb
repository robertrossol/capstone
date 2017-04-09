# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 10.times do
#   name = Faker::Name.first_name+Faker::Name.last_name
#   User.create(
#     :username => name,
#     :email => name+"@email.com",
#     :password => "password",
#     :device_id => "SM"+Faker::Number.number(8),
#     :blood_sugar_lower => "70",
#     :blood_sugar_upper => "200"
#     )
# end
user=User.all
user.each do |user| 
  10.times do
    Entry.create(
      bg: Faker::Number.between(35, 400), user_id: user.id
    )
  end
end