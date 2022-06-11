class ProfilesController < ApplicationController
  def my_profile
    # Gets current user coordinates, currently using static postal code until we fix the Js issue.
    @current_postal_code = 'H2T 1X3'

    # Distance between current user and other users (for index cards).
    @distances_between_other_users = {}

    @profile = User.find(current_user.id)
    @requests = Request.where(receiver: current_user).or(Request.where(giver: current_user))
    @items = @requests.map do |request|
      Item.where(user_id: request.giver_id)
    end
    # All users where the request receiver is the current user
    @users = User.joins(:requests).where(requests: { receiver_id: current_user.id })
    # All booking requests where the pokemon of the booking request's owner id equals mine
    @booking_requests_received = Booking.joins(:pokemons).where(pokemons: { user_id: current_user.id })
    raise
    # Sets distance for each user that's nearby, private method below.
    set_distance(@users)
  end

  private
  # Sets distance for each user that's nearby.
  def set_distance(users)
    # users = User.all
    current_coordinates = Geocoder.coordinates(@current_postal_code)
    users.each do |user|
      total_distance = user.distance_from(current_coordinates).round(1)
      @distances_between_other_users[user.id] = total_distance
    end
  end
end
