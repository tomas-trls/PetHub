# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Pet.destroy_all
User.destroy_all
puts "Seeding started"
puts 'Creating 2 users that are not owners'

2.times do
  user = User.new
  user.email = Faker::Internet.email
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.postcode = Faker::Address.postcode
  user.address = Faker::Address.city
  user.password = "123456"
  user.owner = false
  user.save!
  puts 'User that is not an owner created'
end

# generic users
puts 'Creating 2 users that are owners with 5 pets each'
2.times do
  user = User.new
  user.email = Faker::Internet.email
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.password = "123456"
  user.postcode = Faker::Address.postcode
  user.address = Faker::Address.city
  user.owner = true
  user.save!

  puts "Created user - #{user.id} that is an owner"
  puts "Creating pets for user - #{user.id}"

  5.times do
    pet = Pet.new
    pet.name = Faker::Ancient.god
    pet.species = "Cat"
    pet.breed = Faker::Ancient.titan
    pet.age = rand(1..100)
    pet.description = "I love to eat and catch up on my beauty sleep"
    pet.user = user
    pet.save!
    puts "Pet for user - #{user.id} created"
  end
  puts "All pets for user - #{user.id} created"
end
puts "Seeding done"
