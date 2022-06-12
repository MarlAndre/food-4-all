class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home; end

  def my_favorites
    # For calculating distance between current user and favorited users
    @current_postal_code = 'H2T 1X3'

    # Distance between current user and other users.
    @distances_between_other_users = {}

    # Currently calculating the distance for ALL users each time, would like to reduce this in the future for performance.
    get_distance

    @my_favorites = current_user.all_favorites
  end

  private

  # Sets distance for all users.
  def get_distance(users)
    current_coordinates = Geocoder.coordinates(@current_postal_code)
    users.each do |user|
      @users = User.all
      total_distance = user.distance_from(current_coordinates).round(1)
      @distances_between_other_users[user.id] = total_distance
    end
  end
end
