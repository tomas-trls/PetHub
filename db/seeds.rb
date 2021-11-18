# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
user_url = "https://res.cloudinary.com/ojimoh21/image/upload/v1637064750/development/Animals/Owners/"
user_filenames = ["queen_ut89el.jpg", "male_wcjz7f.jpg", "ross_zd1gpx.jpg", "rihanna_rvx2ex.jpg"]

pet_breeds = ["Cat", "Horse", "Monkey", "Dog", "Hamster"]
pet_url = "https://res.cloudinary.com/ojimoh21/image/upload/v1637064718/development/Animals/"
pet_filenames = ["garfield_2_08_ogsybn.jpg", "horse_qfhd44.jpg", "marcel_q6uihk.jpg", "oscar_qpczyf.jpg", "hamster_w3vowt.jpg"]

Booking.destroy_all
Pet.destroy_all
User.destroy_all
puts "Seeding started"
puts 'Creating 2 users that are not owners'

user_counter = 0
pet_counter = 0

2.times do
  user = User.new
  user.email = Faker::Internet.email
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.postcode = Faker::Address.postcode
  user.address = Faker::Address.city
  user.password = "123456"
  user.owner = false
  user_file = URI.open((user_url + user_filenames[user_counter]).to_s)
  p user_file
  user.photo.attach(io: user_file, filename: (user_filenames[user_counter]).to_s, content_type: 'image/jpg')
  user.save!
  puts 'User that is not an owner created'
  user_counter += 1
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
  user_file = URI.open((user_url + user_filenames[user_counter]).to_s)
  p user_file
  user.photo.attach(io: user_file, filename: (user_filenames[user_counter]).to_s, content_type: 'image/jpg')
  user.save!
  user_counter += 1

  puts "Created user - #{user.id} that is an owner"
  puts "Creating pets for user - #{user.id}"

  5.times do
    pet = Pet.new
    pet.name = Faker::Ancient.god
    pet.species = pet_breeds[pet_counter]
    pet.breed = Faker::Ancient.titan
    pet.age = rand(1..100)
    pet.description = "I love to eat and catch up on my beauty sleep"
    pet.price = rand(20.0..200.0).round(2)
    pet_file = URI.open((pet_url + pet_filenames[pet_counter]).to_s)
    p pet_file
    pet.photo.attach(io: pet_file, filename: (pet_filenames[pet_counter]).to_s, content_type: 'image/jpg')
    pet.user = user
    pet.save!
    puts "Pet for user - #{user.id} created"
    pet_counter += 1
  end
  puts "All pets for user - #{user.id} created"
  pet_counter = 0
end
puts "Seeding done"
