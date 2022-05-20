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

# start_date: Faker::Date.between(from: 3.days.ago, to: 2.days.ago),
# end_date: Faker::Date.between(from: 2.days.from_now, to: 3.days.from_now)

puts "Finished sharing food ♡".light_green
