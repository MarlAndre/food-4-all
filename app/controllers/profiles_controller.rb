class ProfilesController < ApplicationController
  def my_profile
    @profile = User.find(current_user.id)
    @requests = Request.where(receiver: current_user).or(Request.where(giver: current_user))
  end
end
