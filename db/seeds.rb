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

#############################################################################
#----------------------------ARRAYS TO SAMPLE FROM--------------------------#
#############################################################################

@item_types = %w[meal ingredient]
@status_list = %w[available reserved donated]
@allergens_list = %w[peanuts eggs milk soy]
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
# With proper dependencies, deleting the users should delete the entire db.
User.destroy_all

#############################################################################
#----------------------------DEMO PERSONA-----------------------------------#
#############################################################################

# Demo user Justin ('receiver' then time passes and he becomes a 'giver').
justin = User.create!(
  email: 'justin@foodfor.all',
  username: 'Justin',
  password: '123456',
  address: '5333 Av. Casgrain'
)
puts "#{'✓'.light_green} Demo persona: #{justin.username.light_cyan} has been created."
puts '------------------------------------------------------------------------'.light_black

#############################################################################
#-------------------------SEED DB WITH ALLERGENS----------------------------#
#############################################################################

allergen_counter = 0
@allergens_list.length.times do
  allergen = Allergen.create!(name: @allergens_list[allergen_counter])
  allergen_counter += 1
  print "#{allergen.id}. "
  puts allergen.name.light_blue
end
puts "#{'✓ Allergens '.light_green}created"
puts '------------------------------------------------------------------------'.light_black

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
puts '------------------------------------------------------------------------'.light_black

#############################################################################
#-----------------------SEED DB WITH INGREDIENT ITEMS-----------------------#
#-------!These items do not have any allergens or dietary restrictions!-----#
#############################################################################

# Creates users with ingredient items to fill DB.
user = User.create!(
  email: Faker::Internet.email,
  username: Faker::Name.first_name + Faker::Creature::Dog.name,
  password: '123456',
  address: locations.sample
)
puts "#{'✓'.light_green} Demo user: #{user.username.light_cyan} has been created."

5.times do
  ingredient = Item.create!(
    user_id: user.id,
    # name: Faker::Food.dish,
    status: @status_list.sample,
    item_type: 'ingredient',
    description: Faker::Food.description,
    expiration_date: Faker::Date.between(from: 2.days.from_now, to: 5.days.from_now)
  )
end
puts "#{'5'.blue} ingredient items created for #{user.username.light_cyan} "
puts '------------------------------------------------------------------------'.light_black

#############################################################################
#-------------------------SEED DB WITH MEAL ITEMS---------------------------#
#-------!These items DO NOT have any allergens or dietary restrictions!-----#
#############################################################################

# Creates users with meal items to fill DB.
user = User.create!(
  email: Faker::Internet.email,
  username: Faker::Name.first_name + Faker::Creature::Dog.name,
  password: '123456',
  address: locations.sample
)
puts "#{'✓'.light_green} Demo user: #{user.username.light_cyan} has been created."

5.times do
  meal = Item.create!(
    user_id: user.id,
    # name: Faker::Food.dish,
    status: @status_list.sample,
    item_type: 'meal',
    description: Faker::Food.description,
    expiration_date: Faker::Date.between(from: 2.days.from_now, to: 5.days.from_now)
  )
end
puts "#{'5'.blue} meal items created for #{user.username.light_cyan} "
puts '------------------------------------------------------------------------'.light_black

#############################################################################
#-------------------------SEED DB WITH MEAL ITEMS---------------------------#
#----------------------------!WITH ALLERGENS!-------------------------------#
#############################################################################

# Creates users with meal items to fill DB.
user = User.create!(
  email: Faker::Internet.email,
  username: Faker::Name.first_name + Faker::Creature::Dog.name,
  password: '123456',
  address: locations.sample
)
puts "#{'✓'.light_green} Demo user: #{user.username.light_cyan} has been created."

5.times do
  meal = Item.create!(
    user_id: user.id,
    # name: Faker::Food.dish,
    status: @status_list.sample,
    item_type: 'meal',
    description: Faker::Food.description,
    expiration_date: Faker::Date.between(from: 2.days.from_now, to: 5.days.from_now)
  )
end
puts "#{'5'.blue} meal items created for #{user.username.light_cyan} "
puts '------------------------------------------------------------------------'.light_black

#---------------------------------END---------------------------------------#
print '♡ '.light_red
print "Finished sharing food".light_green
puts ' ♡'.light_red
#---------------------------------------------------------------------------#
# Faker::Food.vegetables #=> "Broccolini"
