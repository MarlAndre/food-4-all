class ItemsController < ApplicationController
  # a user doesn't have to log in to visit the index and show pages
  skip_before_action :authenticate_user!, only: :index
  # a user has to log in to like an item
  before_action :find_item, only: %i[show update toggle_favorite]

  def index
    # Gets current user coordinates, currently using static postal code until we fix the Js issue.
    @current_postal_code = 'H2T 1X3'

    # Distance between current user and other users (for index cards).
    @distances_between_other_users = {}

    # Sets distance for each user that's nearby, private method below.
    get_distance

    if @current_postal_code.present?
      # Filter users if items are near (5km)
      @users = User.near(@current_postal_code, 50)

      # Get all of these users items
      @items = @users.map {|u| u.items}.flatten

      # This condition is nested so that the cards will still have the distance from the user.
      if params[:query].present?
        @users = User.all # Maybe this should only reflect the users who's items are shown. <<<<<
        @items = Item.search_index(params[:query])
      end
    elsif params[:query].present?
      @users = User.all
      @items = Item.search_index(params[:query])
    else
      # If no search or postal code was entered, show everything.
      @users = User.all
      @items = Item.all.order(id: :desc)
    end
    # Geocoder
    @geocoded_users = User.geocoded
    @markers = @geocoded_users.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        info_window: render_to_string(
          partial: "info_window",
          locals: { user: user }
        ),
        image_url: helpers.asset_url("map_icon.png")
      }
    end

    # Stimulus controller (MUST be below Geocoder, otherwise markers won't show)
    @items_with_address = @items.map { |item| [item, item.user.address, @distances_between_other_users[item.user.id]] }
    respond_to do |format|
      format.html { render "items/index" }
      format.json { render json: "@items_with_address" }
    end
  end

  def show
    @diets = @item.diets
    @allergens = @item.allergens
    # link the show page to a new or existing request
    if Request.find_by(item_id: @item.id, receiver_id: current_user.id, giver_id: @item.user.id)
      @request = Request.find_by(item_id: @item.id, receiver_id: current_user.id, giver_id: @item.user.id)
    else
      @request = Request.new
    end

    # For the map
    user = @item.user
    @markers = [
      {
        lat: user.latitude,
        lng: user.longitude,
        info_window: render_to_string(
          partial: "info_window",
          locals: { user: user }
        ),
        image_url: helpers.asset_url("map_icon.png")
      }
    ]
  end


  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      add_allergens?
      add_diets?
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def toggle_favorite
    current_user.favorited?(@item) ? current_user.unfavorite(@item) : current_user.favorite(@item)
  end

  def my_items
    @my_available_items = Item.where(user: current_user, status: "available")
    @my_donated_items = Item.where(user: current_user, status: "donated")
    @my_reserved_items = Item.where(user: current_user, status: "reserved")
  end

  def update
    @item.update(item_params)
    redirect_to my_items_path
  end

  private

  def find_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :expiration_date, :status, :item_type, :allergens, :diets, photos: [])
  end

  def add_allergens?
    params[:item][:allergens][1...].each do |allergen|
      if Allergen.find_by(name: allergen)
        ItemsAllergen.create!(item: @item, allergen: Allergen.find_by(name: allergen))
      else
        ItemsAllergen.create!(item: @item, allergen: Allergen.create!(name: allergen))
      end
    end
  end

  def add_diets?
    params[:item][:diets][1...].each do |diet|
      if Diet.find_by(name: diet)
        ItemsDiet.create!(item: @item, diet: Diet.find_by(name: diet))
      else
        ItemsDiet.create!(item: @item, diet: Diet.create!(name: diet))
      end
    end
  end

  # Sets distance for each user that's nearby.
  def get_distance
    users = User.all
    current_coordinates = Geocoder.coordinates(@current_postal_code)
    users.each do |user|
      total_distance = user.distance_from(current_coordinates).round(1)
      @distances_between_other_users[user.id] = total_distance
    end
  end
end
