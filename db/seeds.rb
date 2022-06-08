
# my_item.photos.attach(io: File.open("app/assets/images/meals/pizza.jpg"), filename: "pizza.jpg")

#############################################################################
#------------------------------PARSING JSON---------------------------------#
#############################################################################

# Syntax to parse a JSON file.
# file_path = File.join(Rails.root, 'app', 'assets', 'FILE_NAME_HERE.json')
# file = File.read(file_path)
# list = JSON.parse(file)

# List of local addresses.
locations_file_path = File.join(Rails.root, 'app', 'assets', 'locations.json')
locations_file = File.read(locations_file_path)
@locations = JSON.parse(locations_file)

# List of meals.
meals_file_path = File.join(Rails.root, 'app', 'assets', 'meals.json')
meals_file = File.read(meals_file_path)
@meals = JSON.parse(meals_file)

# List of meals descriptions.
# meal_descriptions_file_path = File.join(Rails.root, 'app', 'assets', 'meal_dessn').description
# meal_descriptions_file = File.read(meal_descriptions_file_path)
# @meal_descriptions = JSON.parse(meal_descriptions_file)

# List of ingredients.
ingredients_file_path = File.join(Rails.root, 'app', 'assets', 'ingredients.json')
ingredients_file = File.read(ingredients_file_path)
@ingredients = JSON.parse(ingredients_file)

#############################################################################
#--------------------------------METHODS------------------------------------#
#############################################################################

# Sets meals and their allergens / diets.
def add_allergens_and_diets(item)
  case item.name
  when 'cauliflower soup'
    item.description = @meals[0]["description"]
    ItemsDiet.create!(item_id: item.id, diet_id: 1)
    ItemsDiet.create!(item_id: item.id, diet_id: 2)
    ItemsDiet.create!(item_id: item.id, diet_id: 3)
    ItemsDiet.create!(item_id: item.id, diet_id: 4)
    ItemsDiet.create!(item_id: item.id, diet_id: 5)
  when 'chicken'
    item.description = @meals[1]["description"]
  when 'mac and cheese with ham'
    item.description = @meals[2]["description"]
    ItemsAllergen.create!(item_id: item.id, allergen_id: 1)
    ItemsAllergen.create!(item_id: item.id, allergen_id: 7)
    ItemsDiet.create!(item_id: item.id, diet_id: 2)
    ItemsDiet.create!(item_id: item.id, diet_id: 3)
  when 'pizza'
    item.description = @meals[3]["description"]
    ItemsAllergen.create!(item_id: item.id, allergen_id: 7)
    ItemsDiet.create!(item_id: item.id, diet_id: 2)
    ItemsDiet.create!(item_id: item.id, diet_id: 3)
  when 'plantain'
    item.description = @meals[4]["description"]
    ItemsDiet.create!(item_id: item.id, diet_id: 1)
    ItemsDiet.create!(item_id: item.id, diet_id: 2)
    ItemsDiet.create!(item_id: item.id, diet_id: 3)
    ItemsDiet.create!(item_id: item.id, diet_id: 4)
    ItemsDiet.create!(item_id: item.id, diet_id: 5)
  when 'salad in a jar'
    item.description = @meals[5]["description"]
    ItemsDiet.create!(item_id: item.id, diet_id: 1)
    ItemsDiet.create!(item_id: item.id, diet_id: 2)
    ItemsDiet.create!(item_id: item.id, diet_id: 3)
    ItemsDiet.create!(item_id: item.id, diet_id: 4)
    ItemsDiet.create!(item_id: item.id, diet_id: 5)
  when 'salmon'
    item.description = @meals[6]["description"]
    ItemsAllergen.create!(item_id: item.id, allergen_id: 3)
    ItemsDiet.create!(item_id: item.id, diet_id: 3)
    ItemsDiet.create!(item_id: item.id, diet_id: 5)
  when 'spaghetti'
    item.description = @meals[7]["description"]

    ItemsAllergen.create!(item_id: item.id, allergen_id: 7)
    ItemsDiet.create!(item_id: item.id, diet_id: 4)
  else
    puts 'error?'.red.blink
  end
  puts " The #{'diets'.light_blue} + #{'allergens'.light_blue} for #{item.name.cyan} have been created"
  puts ''
end
#############################################################################
#----------------------------ARRAYS TO SAMPLE FROM--------------------------#
#############################################################################

@item_types = %w[meal ingredient]
@status_list = %w[available reserved donated]
@allergens_list = ['milk', 'eggs', 'fish', 'shellfish', 'tree nuts', 'peanuts', 'wheat', 'soybeans']
@diets_list = ['vegan', 'vegetarian', 'pescatarian', 'lactose free', 'gluten free']
@true_or_false = [true, false]
# Random simply ingredient descriptions
@ingr_descr = [
  'fresh', 'free', 'extra', 'yummy', 'raw', 'healthy', 'clean', 'delicious', 'fresh picked', 'good for you',
  'hearty', 'locally-grown', 'wholesome', 'ready to be picked up', 'good'
]
#---------------------------------------------------------------------------#

# Clears screen and wipes database
system('clear')
puts "
#{'███████╗░█████╗░░█████╗░██████╗░'.magenta}  #{'░░██╗██╗'.magenta}  ░█████╗░██╗░░░░░██╗░░░░░
#{'██╔════╝██╔══██╗██╔══██╗██╔══██╗'.magenta}  #{'░██╔╝██║'.magenta}  ██╔══██╗██║░░░░░██║░░░░░
#{'█████╗░░██║░░██║██║░░██║██║░░██║'.magenta}  #{'██╔╝░██║'.magenta}  ███████║██║░░░░░██║░░░░░
#{'██╔══╝░░██║░░██║██║░░██║██║░░██║'.magenta}  #{'███████║'.magenta}  ██╔══██║██║░░░░░██║░░░░░
#{'██║░░░░░╚█████╔╝╚█████╔╝██████╔╝'.magenta}  #{'╚════██║'.magenta}  ██║░░██║███████╗███████╗
#{'╚═╝░░░░░░╚════╝░░╚════╝░╚═════╝░'.magenta}  #{'░░░░░╚═╝'.magenta}  ╚═╝░░╚═╝╚══════╝╚══════╝"
puts "Donating the food and resetting the database".red.blink
puts ''
# Due to model associations, this will delete msot of the database.
User.destroy_all

#############################################################################
#-------------------------SEED DB WITH ALLERGENS----------------------------#
#############################################################################
puts '----------------------------Allergens-------------------------------'.light_black

allergen_counter = 0
@allergens_list.length.times do
  next if Allergen.count == 8

  allergen = Allergen.create!(name: @allergens_list[allergen_counter])
  allergen_counter += 1
  print "#{allergen.id}. "
  puts allergen.name.light_blue
end
puts "#{'✓ Allergens '.light_green}created"
puts ''

#############################################################################
#---------------------------SEED DB WITH DIETS------------------------------#
#############################################################################
puts '-----------------------------Diets----------------------------------'.light_black

diet_counter = 0
@diets_list.length.times do
  next if Diet.count == 5

  diet = Diet.create!(name: @diets_list[diet_counter])
  diet_counter += 1
  print "#{diet.id}. "
  puts diet.name.light_blue
end
puts "#{'✓ Diets '.light_green}created"
puts ''

#############################################################################
#----------------------------DEMO PERSONAS-----------------------------------#
#############################################################################
puts '----------------------------Personas--------------------------------'.light_black

# Demo user Justin (starts as 'RECEIVER' then becomes a 'GIVER' by the end of pitch).
@justin = User.create!(
  email: 'justin@foodfor.all',
  username: 'Justin',
  password: '123456',
  address: '5333 Av. Casgrain, montreal'
)
puts " Demo persona: #{@justin.username.light_cyan} has been created."
puts ''
# Demo user Shayna will be the GIVER that justin receives a meal from.
@shayna = User.create!(
  email: 'shayna@foodfor.all',
  username: 'Shayna',
  password: '123456',
  address: '5057 rue de bullion, montreal'
)
shaynas_meal = Item.create!(
  user_id: @shayna.id,
  name: @meals.last["name"],
  status: 'available',
  item_type: 'meal',
  description: @meals.last["description"],
  expiration_date: Faker::Date.between(from: 2.days.from_now, to: 5.days.from_now)
)

puts " Demo persona: #{@shayna.username.light_cyan} has been created with a #{shaynas_meal.name.cyan} meal"
add_allergens_and_diets(shaynas_meal)

# Demo user Williams will be the RECEIVER that justin gives a meal to.
@williams = User.create!(
  email: 'williams@foodfor.all',
  username: 'Williams',
  password: '123456',
  address: '5305 drolet st, montreal'
)
puts " Demo persona: #{@williams.username.light_cyan} has been created to rent #{@shayna.username.light_cyan}'s #{shaynas_meal.name.cyan} meal"
puts "#{'✓ Personas '.light_green}created"
puts ''

#############################################################################
#----------------------------SEED DB WITH USERS-----------------------------#
#############################################################################
puts '------------------------Users with meals----------------------------'.light_black

# Creates users, each user will have a meal to give.
@counter_from_zero = 0
7.times do
  user = User.create!(
    email: Faker::Internet.email,
    username: "#{Faker::Name.first_name.capitalize} #{Faker::Name.last_name.capitalize}",
    password: '123456',
    address: @locations.sample
  )
  meal = Item.create!(
    user_id: user.id,
    name: @meals[@counter_from_zero]["name"],
    status: 'available',
    item_type: 'meal',
    description: @meals[@counter_from_zero]["description"],
    expiration_date: Faker::Date.between(from: 2.days.from_now, to: 5.days.from_now)
  )
  meal.photos.attach(io: File.open("app/assets/images/meals/#{@meals[@counter_from_zero]["photo"]}"), filename: @meals[@counter_from_zero]["photo"])

  puts " #{user.username.light_cyan}(ID:#{user.id.to_s.light_white}) has been created with a #{meal.name.cyan}(ID:#{meal.id.to_s.light_white}) meal."
  add_allergens_and_diets(meal)
  @counter_from_zero += 1
end
puts "#{'✓ Users with meals '.light_green}created"
puts ''
puts '---------------------Users with ingredients-------------------------'.light_black

# Creates users, each user will have an ingredient to give.
@counter_from_zero = 0
25.times do
  user = User.create!(
    email: Faker::Internet.email,
    username: "#{Faker::Name.first_name.capitalize} #{Faker::Name.last_name.capitalize}",
    password: '123456',
    address: @locations.sample
  )
  ingredient = Item.new(
    user_id: user.id,
    name: @ingredients[@counter_from_zero],
    status: 'available',
    item_type: 'ingredient',
    expiration_date: Faker::Date.between(from: 2.days.from_now, to: 5.days.from_now)
    )
  ingredient.description = "#{@ingr_descr.sample} #{ingredient.name}"
  ingredient.save!
  puts " #{user.username.light_cyan}(ID:#{user.id.to_s.light_white}) has been created with ingredient #{ingredient.name.cyan}(ID:#{ingredient.id.to_s.light_white})."
  @counter_from_zero += 1
end
puts "#{'✓ Users with ingredients '.light_green}created"
puts ''

#############################################################################
#---------------------------SEED DB WITH FEEDBACK---------------------------#
#############################################################################
puts '------------------------------Feedback------------------------------'.light_black

5.times do
  # Creates feedback for a user
  feedback = Feedback.create!(
  user_id: @shayna.id,
  punctual: @true_or_false.sample,
  friendly: true,
  communication: true,
  recommended: true
  )
end
puts "#{@shayna.username.light_cyan} has received some feedback."

5.times do
  # Creates feedback for a user
  feedback = Feedback.create!(
  user_id: @williams.id,
  punctual: true,
  friendly: true,
  communication: @true_or_false.sample,
  recommended: true
  )
end
puts "#{@williams.username.light_cyan} has received some feedback."

puts "#{'✓ Feedback'.light_green} created."
puts ''

#############################################################################
#---------------------------SEED DB WITH REQUESTS---------------------------#
#------Comment this out during live demo, this code shouldn't be seen-------#
#############################################################################
puts '-------Fake data for front-end styling commented out for demo-------'.light_black
puts ''

# puts '-------------Fake data for front-end styling (requests)-------------'.light_black

# 5.times do
#   # Creates giver with meal or ingredient item.
#   giver = User.create!(
#     email: Faker::Internet.email,
#     username: (Faker::Name.first_name + Faker::Name.last_name).capitalize,
#     password: '123456',
#     address: @locations.sample
#   )
#   item = Item.create!(
#     user_id: giver.id,
#     name: Faker::Food.dish,
#     status: 'available',
#     item_type: @item_types.sample,
#     description: Faker::Food.description,
#     expiration_date: Faker::Date.between(from: 2.days.from_now, to: 5.days.from_now)
#   )
#   request = Request.create!(
#     giver_id: giver.id,
#     receiver_id: @williams.id,
#     item_id: item.id
#   )
#   puts "Giver: #{giver.username.light_cyan} has #{item.name.to_s.cyan} to give."
#   puts "#{@williams.username.light_cyan} is requesting the #{item.name.to_s.cyan}."
# end
# puts "#{'✓ Requests'.light_green} created."
# puts ''

# this is how we found the way to attached the pictures to each item from the seeds:
# my_item = item.select.first
# my_item.attach(io: File.open("/assets/meals/pizza.jpg"), filename: "pizza.jpg")
#---------------------------------END OF SEED-------------------------------#
print '♡♡♡ '.light_red
print "Finished sharing food".blink
puts ' ♡♡♡'.light_red
