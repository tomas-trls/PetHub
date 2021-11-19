# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
require 'date'
user_url = "https://res.cloudinary.com/ojimoh21/image/upload/v1637064750/development/Animals/Owners/"
user_filenames = ["female_jeetsz.jpg", "Male_wr4n8l.jpg", "images_zgybit.jpg", "young_zdznjj.jpg"]

pet_breeds = ["Cat", "Horse", "Monkey", "Dog", "Hamster"]
pet_url = "https://res.cloudinary.com/ojimoh21/image/upload/v1637064718/development/Animals/"
pet_filenames = ["queens-corgi_epa4xz.jpg", "horse_qfhd44.jpg", "marcel_q6uihk.jpg", "oscar_qpczyf.jpg", "hamster_w3vowt.jpg"]

post_codes = [
  "Hoxton, Hackney, London, Greater London, England, United Kingdom",
  "138 Kingsland Road, Newham, London, E13 9NU, United Kingdom",
  "Circus Street, Oxford, OX4 1JR, United Kingdom",
  "Liverpool, Merseyside, England, United Kingdom",
  "Tottenham Street, Camden, London, W1T 2AW, United Kingdom",
  "Wembley, Greater London, England, United Kingdom"
]

puts "Seeding started"
Booking.destroy_all
Pet.destroy_all
User.destroy_all

user_counter = 0
pet_counter = 0

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
  user_file = URI.open((user_url + user_filenames[user_counter]).to_s)
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
  user.address = post_codes.sample
  user.owner = true
  user_file = URI.open((user_url + user_filenames[user_counter]).to_s)
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
    pet.address = post_codes.sample
    pet.age = rand(1..10)
    pet.description = "I love to eat and catch up on my beauty sleep"
    pet.price = rand(20.0..200.0).round(2)
    pet_file = URI.open((pet_url + pet_filenames[pet_counter]).to_s)
    pet.photo.attach(io: pet_file, filename: (pet_filenames[pet_counter]).to_s, content_type: 'image/jpg')
    pet.user = user
    pet.save!
    puts "Pet for user - #{user.id} created"
    pet_counter += 1
  end
  puts "All pets for user - #{user.id} created"
  pet_counter = 0
end

puts "Creating the queen"
user = User.new
user.email = "queenElizabeth@royal.uk"
user.first_name = "Elizabeth"
user.last_name = "Windsor"
user.password = "123456"
user.postcode = Faker::Address.postcode
user.address = "Buckingham Pal Road, Westminster, London, SW1W 0SR, United Kingdom"
user.owner = true
user_file = URI.open((user_url + user_filenames[0]).to_s)
user.photo.attach(io: user_file, filename: (user_filenames[0]).to_s, content_type: 'image/jpg')
user.save!

5.times do
  pet = Pet.new
  pet.name = Faker::Ancient.god
  pet.species = pet_breeds[pet_counter]
  pet.breed = Faker::Ancient.titan
  pet.age = rand(1..10)
  pet.price = rand(100.0..200.0).round(2)
  pet.address = "Buckingham Palace, london"
  pet.description = "I love to eat and catch up on my beauty sleep"
  pet_file = URI.open((pet_url + pet_filenames[pet_counter]).to_s)
  pet.photo.attach(io: pet_file, filename: (pet_filenames[pet_counter]).to_s, content_type: 'image/jpg')
  pet.user = user
  pet.save!
  puts "Pet for user - #{user.id} created"
  pet_counter += 1
end
pet_counter += 0

# upcoming and pending
puts "Adding bookmark with status pending"

# One day booking of queen's pet that is pending and today
booking = Booking.new
booking.start_date = Date.today
booking.end_date = Date.today
booking.pet = User.last.pets[0]
booking.price = (booking.end_date - booking.start_date + 1) * booking.pet.price
booking.user = User.first
booking.save!

# One day booking by queen that is pending and today
booking = Booking.new
booking.start_date = Date.today
booking.end_date = Date.today
booking.pet = User.all[3].pets[2]
booking.price = (booking.end_date - booking.start_date + 1) * booking.pet.price
booking.user = User.last
booking.save!

# Multiple days, future booking by queen that is pending
booking = Booking.new
booking.start_date = Date.today
booking.end_date = booking.start_date.advance(days: 10)
booking.pet = User.all[3].pets[2]
booking.price = (booking.end_date - booking.start_date + 1) * booking.pet.price
booking.user = User.last
booking.save!

# upcoming and accepted
puts "Adding bookmark with status accepted"

# Multiple day booking of queen's pet that is accepted
booking = Booking.new
booking.start_date = Date.today + 3
booking.end_date = Date.today + 5
booking.pet = User.last.pets[1]
booking.price = (booking.end_date - booking.start_date + 1) * booking.pet.price
booking.user = User.first
booking.bookingStatus = "accepted"
booking.save!

# Multiple day booking by queen that is accepted
booking = Booking.new
booking.start_date = Date.today + 2
booking.end_date = Date.today + 6
booking.pet = User.all[3].pets[3]
booking.price = (booking.end_date - booking.start_date + 1) * booking.pet.price
booking.user = User.last
booking.bookingStatus = "accepted"
booking.save!

# upcoming and cancelled
puts "Adding bookmark that is cancelled"

# Multiple day booking of queen's pet that is was cancelled by queen
booking = Booking.new
booking.start_date = Date.today + 3
booking.end_date = booking.start_date + 10
booking.pet = User.last.pets[2]
booking.price = (booking.end_date - booking.start_date + 1) * booking.pet.price
booking.user = User.first
booking.bookingStatus = "cancelled"
booking.save!

# Multiple day booking by queen that was cancelled by owner
booking = Booking.new
booking.start_date = Date.today + 5
booking.end_date = booking.start_date + 8
booking.pet = User.all[3].pets[3]
booking.price = (booking.end_date - booking.start_date + 1) * booking.pet.price
booking.user = User.last
booking.bookingStatus = "cancelled"
booking.save!

# past and completed
puts "Adding bookmark that has been completed"

# Multiple day past booking of queen's pet that is accepted
booking = Booking.new
booking.start_date = Date.today - 10
booking.end_date = Date.today - 8
booking.pet = User.last.pets[3]
booking.price = (booking.end_date - booking.start_date + 1) * booking.pet.price
booking.user = User.first
booking.bookingStatus = "accepted"
booking.owner_confirmation = true
booking.sitter_confirmation = true
booking.save!

# Multiple day past booking by queen that is accepted
booking = Booking.new
booking.start_date = Date.today - 6
booking.end_date = Date.today - 4
booking.pet = User.all[3].pets[3]
booking.price = (booking.end_date - booking.start_date + 1) * booking.pet.price
booking.user = User.last
booking.bookingStatus = "accepted"
booking.owner_confirmation = true
booking.sitter_confirmation = true
booking.save!
puts "Seeding done"
