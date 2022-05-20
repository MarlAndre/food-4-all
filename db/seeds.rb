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
@diets_list = %w[vegan vegetarian 'lactose intolerant' 'gluten free' pescatarian]
#---------------------------------------------------------------------------#

# Clears screen and wipes database
system('clear')
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
puts "#{'✓'.green} Demo persona: #{justin.username.light_cyan} has been created."
puts '-'.light_black

#############################################################################
#----------------------------SEED DB WITH ITEMS-----------------------------#
#############################################################################


# Creates users with items to fill DB.
user = User.create!(
  email: Faker::Internet.email,
  username: Faker::Name.first_name + Faker::Creature::Dog.name,
  password: '123456',
  address: locations.sample
)

5.times do
  Item.create!(
    user_id: user.id,
    status: @status_list.sample,
    item_type: @item_types.sample,
    description: 'Description here',
    expiration_date: Faker::Date.between(from: 2.days.from_now, to: 5.days.from_now),
  )
end
puts "#{'✓'.green} Demo persona: #{user.username.light_cyan} has been created."
puts '-'.light_black

#---------------------------------END---------------------------------------#
print '♡ '.light_red
print "Finished sharing food".light_green
puts ' ♡'.light_red
#---------------------------------------------------------------------------#
