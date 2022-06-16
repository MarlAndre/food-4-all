class ProfilesController < ApplicationController
  def my_profile
    # Gets current user coordinates, currently using static postal code until we fix the Js issue.
    @current_postal_code = 'Montreal, Av. casgrain'

    # Distance between current user and other users (for index cards).
    @distances_between_other_users = {}

    @profile = User.find(current_user.id)

    # Items that the current user has requested.
    @items = Item.joins(:requests).where(requests: {receiver_id: current_user.id })

    # All users where the request receiver is the current user
    @users = User.joins(:requests_as_giver).where(requests_as_giver: { receiver_id: current_user.id })

    # Sets distance for each user that's nearby, private method below.
    get_distance(@users)
  end

  private

  # Sets distance for each user that's nearby.
  def get_distance(users)
    # users = User.all
    current_coordinates = Geocoder.coordinates(@current_postal_code)
    users.each do |user|
      total_distance = user.distance_from(current_coordinates).round(1)
      @distances_between_other_users[user.id] = total_distance
    end
  end
end
