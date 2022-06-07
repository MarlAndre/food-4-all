class ProfilesController < ApplicationController
  def my_profile
    @profile = User.find(current_user.id)
  end
end
