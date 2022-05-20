#############################################################################
#------------------------------PARSING JSON---------------------------------#
#############################################################################

# Syntax to parse a JSON file.
# file_path = File.join(Rails.root, 'app', 'assets', 'FILE_NAME_HERE.json')
# file = File.read(file_path)
# list = JSON.parse(file)

# Parses JSON file with a list of local addresses.
locations_file_path = File.join(Rails.root, 'app', 'assets', 'locations.json')
locations_file = File.read(locations_file_path)
locations = JSON.parse(locations_file)
#---------------------------------------------------------------------------#

# Clears screen and wipes database
system('clear')
puts "Clearing the database".red.blink
puts ''
# With proper dependencies, deleting the users should delete the entire db.
User.destroy_all

#############################################################################
#--------------------------------RECEIVER-----------------------------------#
#############################################################################

# First demo user Justin (receiver).
demo_receiver = User.create!(
  email: 'receiver@foodfor.all',
  username: 'Justin',
  password: '123456',
  address: 'montreal'
)
puts "#{'✓'.green} Demo receiver: #{demo_receiver.username.light_cyan} is ready to rent pokemons:"
puts '-'.light_black

#############################################################################
#---------------------------------GIVER-------------------------------------#
#############################################################################

# Prevents Gary from having other plusle and minun pokemons for demo
def avoid_duplicate_cuties
  cuties = %w[plusle minun]
  species = @species_list.sample
  species = @species_list.sample while cuties.include?(species.downcase)
  species
end

# Second demo user Gary (owner).
demo_owner = User.create!(
  email: 'owner@pokemon.do',
  username: 'Gary',
  password: '123456'
)
demo_owner_address = '5333 Av. Casgrain'
puts "#{'✓'.green} Demo owner: #{demo_owner.username.light_cyan} is ready to rent out his pokemons:"
puts '-'.light_black

# This section is commented out because Gary has way too many pokemons
# Creates x amount of pokemon for demo_user Gary (to own) with no bookings.
# 3.times do
#   species = @species_list.sample
#   Pokemon.create!(
#     user_id: demo_owner.id,
#     name: Faker::Creature::Dog.name,
#     species: species,
#     description: Faker::Games::Pokemon.move,
#     location: demo_owner_address,
#     price: rand(25..65),
#     image_url: "https://img.pokemondb.net/artwork/large/#{species.downcase}.jpg"
#   )
# end

#############################################################################
#-----------------------------CURRENT BOOKINGS------------------------------#
#############################################################################

# Creates x amount of current bookings. Each booking will have a generated receiver and pokemon.
# The owner of the pokemons in the bookings will be Gary, the demo owner user.
3.times do
  species = avoid_duplicate_cuties
  pokemon = Pokemon.create!(
    user_id: demo_owner.id,
    name: Faker::Creature::Dog.name,
    species: species,
    description: Faker::Games::Pokemon.move,
    location: demo_owner_address,
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{species.downcase}.jpg"
  )

  receiver = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )

  Booking.create!(
    pokemon_id: pokemon.id,
    user_id: receiver.id,
    start_date: Faker::Date.between(from: 3.days.ago, to: 2.days.ago),
    end_date: Faker::Date.between(from: 2.days.from_now, to: 3.days.from_now)
  )
end

# Creates x amount of current bookings. Each booking, Gary is RENTING the pokemon.
# The owner of the pokemons in the bookings will be a new generated receiver.
1.times do
  receiver = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )

  species = @species_list.sample
  pokemon = Pokemon.create!(
    user_id: receiver.id,
    name: Faker::Creature::Dog.name,
    species: species,
    description: Faker::Games::Pokemon.move,
    location: cities_list.sample,
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{species.downcase}.jpg"
  )

  Booking.create!(
    pokemon_id: pokemon.id,
    user_id: demo_owner.id,
    start_date: Faker::Date.between(from: 3.days.ago, to: 2.days.ago),
    end_date: Faker::Date.between(from: 2.days.from_now, to: 3.days.from_now)
  )
end

puts "#{'✓'.green} #{demo_owner.username.light_cyan}'s current bookings are ready."
puts '-'.light_black

#############################################################################
#----------------------------UPCOMING BOOKINGS------------------------------#
#############################################################################

# Creates x amount of upcoming bookings. Each booking will have a generated receiver and pokemon.
# The owner of the pokemons in the bookings will be Gary, the demo owner user.
3.times do
  species = avoid_duplicate_cuties
  pokemon = Pokemon.create!(
    user_id: demo_owner.id,
    name: Faker::Creature::Dog.name,
    species: species,
    description: Faker::Games::Pokemon.move,
    location: demo_owner_address,
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{species.downcase}.jpg"
  )

  receiver = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )

  Booking.create!(
    pokemon_id: pokemon.id,
    user_id: receiver.id,
    start_date: Faker::Date.between(from: 3.days.from_now, to: 5.days.from_now),
    end_date: Faker::Date.between(from: 5.days.from_now, to: 10.days.from_now)
  )
end

# Creates x amount of upcoming bookings. Each booking, Gary is RENTING the pokemon.
# The owner of the pokemons in the bookings will be a new generated receiver.
2.times do
  receiver = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )

  species = @species_list.sample
  pokemon = Pokemon.create!(
    user_id: receiver.id,
    name: Faker::Creature::Dog.name,
    species: species,
    description: Faker::Games::Pokemon.move,
    location: cities_list.sample,
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{species.downcase}.jpg"
  )

  Booking.create!(
    pokemon_id: pokemon.id,
    user_id: demo_owner.id,
    start_date: Faker::Date.between(from: 3.days.from_now, to: 5.days.from_now),
    end_date: Faker::Date.between(from: 5.days.from_now, to: 10.days.from_now)
  )
end

puts "#{'✓'.green} #{demo_owner.username.light_cyan}'s upcoming bookings are ready."
puts '-'.light_black

#############################################################################
#------------------------------PAST BOOKINGS--------------------------------#
#############################################################################

# Creates x amount of past bookings. Each booking will have a generated receiver and pokemon.
# The owner of the pokemons in the bookings will be Gary, the demo owner user.
5.times do
  species = avoid_duplicate_cuties
  pokemon = Pokemon.create!(
    user_id: demo_owner.id,
    name: Faker::Creature::Dog.name,
    species: species,
    description: Faker::Games::Pokemon.move,
    location: demo_owner_address,
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{species.downcase}.jpg"
  )

  receiver = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )

  booking = Booking.create!(
    pokemon_id: pokemon.id,
    user_id: receiver.id,
    start_date: Faker::Date.between(from: 15.days.ago, to: 10.days.ago),
    end_date: Faker::Date.between(from: 10.days.ago, to: 2.days.ago)
  )
end

# Creates specific pokemon to make a past booking with during demo, owner is Gary (pokemon_id: to_confirm?)
demo_pokemon = Pokemon.create!(
user_id: demo_owner.id,
name: 'Hercules',
species: 'machamp',
description: 'Great for heavy lifting and building!',
location: demo_owner_address,
price: 25,
image_url: "https://img.pokemondb.net/artwork/large/machamp.jpg"
)
# Adds receiver to leave a review
reviewing_receiver = User.create!(
  email: 'reviewer@pokemon.do',
  username: 'Andrii',
  password: '123456'
)
reviewing_receiver_two = User.create!(
  email: 'reviewer_two@pokemon.do',
  username: 'JF',
  password: '123456'
)
reviewing_receiver_three = User.create!(
  email: 'reviewer_three@pokemon.do',
  username: 'Joe',
  password: '123456'
)
# Makes booking so receiver can leave a review
demo_booking = Booking.create!(
  pokemon_id: demo_pokemon.id,
  user_id: reviewing_receiver.id,
  start_date: Faker::Date.between(from: 15.days.ago, to: 10.days.ago),
  end_date: Faker::Date.between(from: 10.days.ago, to: 2.days.ago)
)
demo_booking_two = Booking.create!(
  pokemon_id: demo_pokemon.id,
  user_id: reviewing_receiver_two.id,
  start_date: Faker::Date.between(from: 15.days.ago, to: 10.days.ago),
  end_date: Faker::Date.between(from: 10.days.ago, to: 2.days.ago)
)
demo_booking_three = Booking.create!(
  pokemon_id: demo_pokemon.id,
  user_id: reviewing_receiver_three.id,
  start_date: Faker::Date.between(from: 15.days.ago, to: 10.days.ago),
  end_date: Faker::Date.between(from: 10.days.ago, to: 2.days.ago)
)
# Adds reviews for the demo booking pokemon
PokemonReview.create!(
  content: reviews[7][:content],
  rating: reviews[7][:rating],
  booking: demo_booking,
  user: reviewing_receiver
)
PokemonReview.create!(
  content: reviews[8][:content],
  rating: reviews[8][:rating],
  booking: demo_booking_two,
  user: reviewing_receiver_two
)
PokemonReview.create!(
  content: reviews[9][:content],
  rating: reviews[9][:rating],
  booking: demo_booking_three,
  user: reviewing_receiver_three
)

# Creates x amount of past bookings. Each booking, Gary RENTED the pokemon.
# The owner of the pokemons in the bookings will be a new generated receiver.
8.times do
  receiver = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )

  species = @species_list.sample
  pokemon = Pokemon.create!(
    user_id: receiver.id,
    name: Faker::Creature::Dog.name,
    species: species,
    description: Faker::Games::Pokemon.move,
    location: cities_list.sample,
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{species.downcase}.jpg"
  )

  Booking.create!(
    pokemon_id: pokemon.id,
    user_id: demo_owner.id,
    start_date: Faker::Date.between(from: 15.days.ago, to: 10.days.ago),
    end_date: Faker::Date.between(from: 10.days.ago, to: 2.days.ago)
  )
end

puts "#{'✓'.green} #{demo_owner.username.light_cyan}'s past bookings are ready."
puts '-'.light_black

#############################################################################
#--------------------------SEEDING DB WITH POKEMONS-------------------------#
#############################################################################

# Creates cute 'minun' pokemon for demo, it'll be Gary's last pokemon
Pokemon.create!(
  user_id: demo_owner.id,
  name: 'Cutie patootie',
  species: 'Minun',
  description: 'Gives great hugs!',
  location: '5353 Casgrain Av',
  price: 80,
  image_url: "https://img.pokemondb.net/artwork/large/minun.jpg"
)
# Creates a 'machamp' pokemon + its owner with a far location, to compare with Gary's pokemon during demo day
receiver = User.create!(
  email: Faker::Internet.email,
  username: Faker::Name.first_name + Faker::Name.first_name,
  password: '123456'
)

Pokemon.create!(
  user_id: receiver.id,
  name: 'Muscles',
  description: 'Can break rocks better than you can!',
  location: '1925 Brookdale Dorval',
  species: 'machamp',
  price: 34,
  image_url: "https://img.pokemondb.net/artwork/large/machamp.jpg"
)

# Seed database with x amount of pokemons and their owner.
50.times do
  pokemon_owner = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )
  print "Pokemon owner #{pokemon_owner.username.light_cyan}(ID: #{pokemon_owner.id.to_s.light_cyan}) signed up and started renting out their "

  species = avoid_duplicate_cuties
  pokemon = Pokemon.create!(
    user_id: pokemon_owner.id,
    name: Faker::Creature::Dog.name,
    species: species,
    description: Faker::Games::Pokemon.move,
    location: cities_list.sample,
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{species.downcase}.jpg"
  )
  puts "#{pokemon.name.cyan} the #{pokemon.species.magenta}(ID: #{pokemon.id.to_s.magenta})!"
  puts ''
  puts '----------------------------------------------------------------------------------------------------'.light_black
  puts ''
end

# Creates a 'machamp' pokemon and its owner with a high price, to compare with Gary's pokemon during demo day.
# The machamp will have 3 star review
receiver = User.create!(
  email: Faker::Internet.email,
  username: Faker::Name.first_name + Faker::Name.first_name,
  password: '123456'
)

pokemon = Pokemon.create!(
  user_id: receiver.id,
  name: 'Goliath',
  description: 'Has strong arms for heavy lifting',
  location: cities_list.sample,
  species: 'Machamp',
  price: 99,
  image_url: "https://img.pokemondb.net/artwork/large/machamp.jpg"
)

booking = Booking.create!(
  pokemon_id: pokemon.id,
  user_id: demo_owner.id,
  start_date: Faker::Date.between(from: 15.days.ago, to: 10.days.ago),
  end_date: Faker::Date.between(from: 10.days.ago, to: 2.days.ago)
)

PokemonReview.create!(
  content: reviews[5][:content],
  rating: reviews[5][:rating],
  booking: booking,
  user: booking.user
)

puts 'Creating reviews for each pokemon booked'.light_blue

# Seeds reviews for each booking (tied to pokemon)
Booking.all.each do |booking|
  unless booking.pokemon.name == 'Hercules' || booking.pokemon.name == 'Goliath'
    review_details = reviews.sample
    review = PokemonReview.create!(
      content: review_details[:content],
      rating: review_details[:rating],
      booking: booking,
      user: booking.user
    )
    puts "#{booking.user.username.cyan} rated #{review.booking.pokemon.name.magenta} #{review.rating.to_s.yellow} stars!"
    puts ''
    puts '-------------------------------'.light_black
    puts ''
  end
end

# Makes a booking so we can leave a review as Gary, who RENTED the pokemon
receiver = User.create!(
  email: Faker::Internet.email,
  username: Faker::Name.first_name + Faker::Name.first_name,
  password: '123456'
)

species = avoid_duplicate_cuties
pokemon = Pokemon.create!(
  user_id: receiver.id,
  name: Faker::Creature::Dog.name,
  species: species,
  description: 'Greatest pokemon!',
  location: 'Montreal, Lasalle',
  price: rand(65),
  image_url: "https://img.pokemondb.net/artwork/large/#{species.downcase}.jpg"
)

booking = Booking.create!(
  pokemon_id: pokemon.id,
  user_id: demo_owner.id,
  start_date: Faker::Date.between(from: 15.days.ago, to: 10.days.ago),
  end_date: Faker::Date.between(from: 3.days.ago, to: 2.days.ago)
)

puts "Finished catching and preparing pokemons :)".light_green
