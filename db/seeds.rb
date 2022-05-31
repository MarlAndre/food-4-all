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
meal_descriptions_file_path = File.join(Rails.root, 'app', 'assets', 'meal_descriptions.json')
meal_descriptions_file = File.read(meal_descriptions_file_path)
@meal_descriptions = JSON.parse(meal_descriptions_file)

# List of ingredients.
ingredients_file_path = File.join(Rails.root, 'app', 'assets', 'ingredients.json')
ingredients_file = File.read(ingredients_file_path)
@ingredients = JSON.parse(ingredients_file)

#############################################################################
#--------------------------------METHODS------------------------------------#
#############################################################################

# FIX THIS ISSUE
def add_allergens_and_diets(item)
  case item.name
  when 'cauliflower soup' then item.description = @meal_descriptions[0]
  when 'chicken' then item.description = @meal_descriptions[0]
  when 'mac and cheese with ham' then item.description = @meal_descriptions[0]
  when 'pizza' then item.description = @meal_descriptions[0]
  when 'plantain' then item.description = @meal_descriptions[0]
  when 'salad in a jar' then item.description = @meal_descriptions[0]
  when 'salmon' then item.description = @meal_descriptions[0]
  # when 'spaghetti' then puts 'spaghetti'
  else
    puts 'error?'.red.blink
  end
end

#############################################################################
#----------------------------ARRAYS TO SAMPLE FROM--------------------------#
#############################################################################

@item_types = %w[meal ingredient]
@status_list = %w[available reserved donated]
@allergens_list = ['milk', 'eggs', 'fish', 'shellfish', 'tree nuts', 'peanuts', 'wheat', 'soybeans']
@diets_list = ['vegan', 'vegetarian', 'lactose intolerant', 'gluten free', 'pescatarian']
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

allergen_counter = 0
@allergens_list.length.times do
  next if Allergen.count == 8

  allergen = Allergen.create!(name: @allergens_list[allergen_counter])
  allergen_counter += 1
  print "#{allergen.id}. "
  puts allergen.name.light_blue
end
puts "#{'✓ Allergens '.light_green}created"
puts '--------------------------------------------------------------------'.light_black

#############################################################################
#---------------------------SEED DB WITH DIETS------------------------------#
#############################################################################

diet_counter = 0
@diets_list.length.times do
  diet = Diet.create!(name: @diets_list[diet_counter])
  diet_counter += 1
  print "#{diet.id}. "
  puts diet.name.light_blue
end
puts "#{'✓ Diets '.light_green}created"
puts '--------------------------------------------------------------------'.light_black

#############################################################################
#----------------------------DEMO PERSONAS-----------------------------------#
#############################################################################

# Demo user Justin (starts as 'RECEIVER' then becomes a 'GIVER' by the end of pitch).
justin = User.create!(
  email: 'justin@foodfor.all',
  username: 'Justin',
  password: '123456',
  address: '5333 Av. Casgrain, montreal'
)
puts "#{'✓'.light_green} Demo persona: #{justin.username.light_cyan} has been created."

# Demo user Shayna will be the GIVER that justin receives a meal from.
shayna = User.create!(
  email: 'shayna@foodfor.all',
  username: 'Shayna',
  password: '123456',
  address: '5057 rue de bullion, montreal'
)
shaynas_meal = Item.create!(
  user_id: shayna.id,
  name: @meals.last,
  status: 'available',
  item_type: 'meal',
  description: @meal_descriptions.last,
  expiration_date: Faker::Date.between(from: 2.days.from_now, to: 5.days.from_now)
)
puts "#{'✓'.light_green} Demo persona: #{shayna.username.light_cyan} has been created. with a #{shaynas_meal.name.green.blink}"
puts "#{'✓'.light_green} Demo persona: #{shayna.username.light_cyan} has been created."

# Demo user Williams will be the RECEIVER that justin gives a meal to.
williams = User.create!(
  email: 'williams@foodfor.all',
  username: 'Williams',
  password: '123456',
  address: '5305 drolet st, montreal'
)
puts "#{'✓'.light_green} Demo persona: #{williams.username.light_cyan} has been created."
puts '--------------------------------------------------------------------'.light_black

#############################################################################
#----------------------------SEED DB WITH USERS-----------------------------#
#############################################################################

# Creates users, further below each meal/ingredient will be applied to each user.
32.times do
  user = User.create!(
    email: Faker::Internet.email,
    username: (Faker::Name.first_name + Faker::Name.last_name).downcase,
    password: '123456',
    address: @locations.sample
  )
  puts "#{'✓'.light_green} Demo user: ID:#{user.id.to_s.light_white} - #{user.username.light_cyan} has been created."
end

# 5.times do
#   ingredient = Item.create!(
#     user_id: user.id,
#     name: Faker::Food.vegetables,
#     status: @status_list.sample,
#     item_type: 'ingredient',
#     description: Faker::Food.description,
#     expiration_date: Faker::Date.between(from: 2.days.from_now, to: 5.days.from_now)
#   )
# end
# puts "#{'5'.blue} ingredient items created for #{user.username.light_cyan} "
puts '--------------------------------------------------------------------'.light_black

#############################################################################
#-------------------------SEED DB WITH MEAL ITEMS---------------------------#
#############################################################################

# Creates @ for existing users.
user_id_counter = williams.id + 1
counter_from_zero = 0
7.times do
  meal = Item.create!(
    user_id: user_id_counter,
    name: @meals[counter_from_zero],
    status: 'available',
    item_type: 'meal',
    description: @meal_descriptions[counter_from_zero],
    expiration_date: Faker::Date.between(from: 2.days.from_now, to: 5.days.from_now)
  )

  add_allergens_and_diets(meal)
  user_id_counter += 1
  counter_from_zero += 1
  puts "meal items created for #{meal.user.username.light_cyan} "
  puts ''
  puts meal.description
  puts ''
end

puts "#{'✓'.light_green} #{'7'.blue} meal items created"
puts '--------------------------------------------------------------------'.light_black

#############################################################################
#-------------------------SEED DB WITH MEAL ITEMS---------------------------#
#----------------------------!WITH ALLERGENS!-------------------------------#
#############################################################################

# Creates users with meal items to fill DB.
user = User.create!(
  email: Faker::Internet.email,
  username: (Faker::Name.first_name + Faker::Name.last_name).downcase,
  password: '123456',
  address: @locations.sample
)
puts "#{'✓'.light_green} Demo user: #{user.username.light_cyan} has been created."

5.times do
  meal = Item.create!(
    user_id: user.id,
    name: Faker::Food.dish,
    status: @status_list.sample,
    item_type: 'meal',
    description: Faker::Food.description,
    expiration_date: Faker::Date.between(from: 2.days.from_now, to: 5.days.from_now)
  )
  ItemsAllergen.create!(
    item_id: meal.id,
    allergen_id: rand(1..4)
  )
end
puts "#{'5'.blue} meal items #{'with allergens'.light_blue} created for #{user.username.light_cyan} "
puts '--------------------------------------------------------------------'.light_black

#############################################################################
#-------------------------SEED DB WITH MEAL ITEMS---------------------------#
#-------------------------------!WITH DIETS!--------------------------------#
#############################################################################

# Creates users with meal items to fill DB.
user = User.create!(
  email: Faker::Internet.email,
  username: (Faker::Name.first_name + Faker::Name.last_name).downcase,
  password: '123456',
  address: @locations.sample
)
puts "#{'✓'.light_green} Demo user: #{user.username.light_cyan} has been created."

5.times do
  meal = Item.create!(
    user_id: user.id,
    name: Faker::Food.dish,
    status: @status_list.sample,
    item_type: 'meal',
    description: Faker::Food.description,
    expiration_date: Faker::Date.between(from: 2.days.from_now, to: 5.days.from_now)
  )
  ItemsDiet.create!(
    item_id: meal.id,
    diet_id: rand(1..5)
  )
end
puts "#{'5'.blue} meal items #{'with diets'.light_blue} created for #{user.username.light_cyan} "
puts '--------------------------------------------------------------------'.light_black

#############################################################################
#-------------------------SEED DB WITH REQUESTS-------------------------#
#############################################################################

5.times do
  # Creates receiver with meal or ingredient item for request.
  receiver = User.create!(
    email: Faker::Internet.email,
    username: (Faker::Name.first_name + Faker::Name.last_name).downcase,
    password: '123456',
    address: @locations.sample
  )
  puts "Receiver: #{receiver.username.cyan} has been created."

  # Creates giver with meal or ingredient item for request.
  giver = User.create!(
    email: Faker::Internet.email,
    username: (Faker::Name.first_name + Faker::Name.last_name).downcase,
    password: '123456',
    address: @locations.sample
  )
  puts "Giver: #{giver.username.light_cyan} has been created."

  meal = Item.create!(
    user_id: giver.id,
    name: Faker::Food.dish,
    status: 'reserved',
    item_type: @item_types.sample,
    description: Faker::Food.description,
    expiration_date: Faker::Date.between(from: 2.days.from_now, to: 5.days.from_now)
  )

  # If the item is a meal, it might have an allergen or dietary restriction.
  if meal.item_type == 'meal'
    allergen_or_diet = rand(1..3)
    case allergen_or_diet
    when 1
      ItemsAllergen.create!(
        item_id: meal.id,
        allergen_id: rand(1..4)
      )
    when 2
      ItemsDiet.create!(
        item_id: meal.id,
        diet_id: rand(1..5)
      )
    end
    request = Request.create!(
      giver_id: giver.id,
      receiver_id: receiver.id,
      item_id: meal.id
    )
  end
  puts "#{'✓'.light_green} #{giver.username.light_cyan} just gave #{receiver.username.cyan} a #{meal.name.cyan} meal."
  puts '--------------------------------------------------------------------'.light_black
end

#---------------------------------END OF SEED-------------------------------#
print '♡ '.light_red
print "Finished sharing food".light_green
puts ' ♡'.light_red
