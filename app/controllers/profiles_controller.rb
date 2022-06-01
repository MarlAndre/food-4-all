class ProfilesController < ApplicationController
  before_action :find_profile
  def show
    verify_current_user
  end

  private

  def find_profile
    @profile = User.find(params[:id])
  end

  # current user can only visit his/her own profile page.
  def verify_current_user
    redirect_to profile_path(current_user) unless @profile == current_user
  end
end
