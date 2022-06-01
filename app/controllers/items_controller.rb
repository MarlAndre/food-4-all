class ItemsController < ApplicationController
  # a user doesn't have to log in to visit the index and show pages
  skip_before_action :authenticate_user!, only: %i[index show]
  # a user has to log in to like an item
  before_action :authenticate_user!, only: %i[toggle_favorite]
  before_action :find_item, only: %i[show toggle_favorite]

  def index
    if params[:query].present?
      @items = Item.search_index(params[:query])
    else
      @items = Item.all.order(id: :desc)
      @items
    end

    # Filter by postal code
    if params[:postal_code].present?
      # Filter users if items are near (5km)
      @users = User.near(params[:postal_code], 5)
      # Get all of these users items
      @items = @users.map {|u| u.items}.flatten
    end

    # Stimulus controller
    respond_to do |format|
      format.html { render "items/index" }
      format.json { render json: @items }
    end

    # Geocoder
    # @markers = @users.geocoded.map do |user|
    #   {
    #     lat: user.latitude,
    #     lng: user.longitude
    #   }
    # end
  end

  def show
    # link the show page to a new or existing request
    if Request.find_by(item_id: @item.id, receiver_id: current_user.id, giver_id: @item.user.id)
      @request = Request.find_by(item_id: @item.id, receiver_id: current_user.id, giver_id: @item.user.id)
    else
      @request = Request.new
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def toggle_favorite
    current_user.favorited?(@item) ? current_user.unfavorite(@item) : current_user.favorite(@item)
  end

  private

  def find_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :expiration_date, :status, :item_type)
  end
end
