class RequestsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    # current user can only view the chats where s/he is a receiver/giver.
    @requests = Request.where(receiver: current_user).or(Request.where(giver: current_user))
  end

  # make sure only the current users can access the page, otherwise redirect to Requests#index page.
  def show
    @request = Request.find(params[:id])
    @item = @request.item
    @distance = @item.distance_from(current_user.address).round(1)
    if current_user == @request.giver || current_user == @request.receiver
      @message = Message.new
    else
      redirect_to requests_path
    end
  end

  def create
    @request = Request.new
    @request.receiver = current_user
    @request.item = Item.find(params[:request][:item_id])
    @request.giver = @request.item.user
    if @request.save
      redirect_to request_path(@request)
    else
      render "items/show"
    end
  end

  private

  # Sets distance for each user that's nearby.
  def calculate_distance
    users = User.all
    current_coordinates = Geocoder.coordinates(@current_postal_code)
    users.each do |user|
      current_coordinates
      total_distance = user.distance_from(current_coordinates).round(1)
      @distances_between_other_users[user.id] = total_distance
    end
  end
end
