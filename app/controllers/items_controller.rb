class ItemsController < ApplicationController
  # a user doesn't have to log in to visit the index and show pages
  skip_before_action :authenticate_user!, only: :index
  # a user has to log in to like an item
  before_action :find_item, only: %i[show toggle_favorite]

  def index
<<<<<<< HEAD
    puts "\n\n\n ------------!Index called!------------- \n\n\n".light_green.blink

    # Filter by postal code POSTAL CODE RESETS EACH TIME YOU GO BACK TO INDEX! <<<<<<<<<<<<<<
    # It's impossible to use a 'raise' anytime a postal code is entered in the pop up. <<<<<<<<<<<<<<
    @current_postal_code = params[:postal_code]

    # Gets current user coordinates from the postal code the user entered, default is Montreal coordinates if none entered.
    # Postal code is not saving? <<<<<<<<<<<<<<
    @current_coordinates = Geocoder.coordinates(@current_postal_code) || Geocoder.coordinates("Montreal")

    # Distance between current user and other users (for index cards)
    @distances_between_other_users = {}
    if @current_postal_code.present?
      puts "\n\n\n ------------params postal code #{@current_postal_code}------------- \n\n\n".green.blink

=======
    # Filter by postal code
    if params[:postal_code].present?
>>>>>>> master
      # Filter users if items are near (5km)
      @users = User.near(@current_postal_code, 5)

      # Get all of these users items
<<<<<<< HEAD
      @items = @users.map {|user| user.items}.flatten

      # Sets distance for each user that's nearby.
      @users.each do |user|
        total_distance = user.distance_from(@current_coordinates).round(1)
        @distances_between_other_users[user.id] = total_distance
      end
      # merge this
    else
      @users = User.all
    end

    if params[:query].present?
      @items = Item.search_index(params[:query])
    else
      @items = Item.all.order(id: :desc)
    end

    # Geocoder
    @markers = @users.geocoded.map do |user|
=======
      @items = @users.map {|u| u.items}.flatten
    elsif params[:query].present?
      @items = Item.search_index(params[:query])
      @users = User.all
    else
      @items = Item.all.order(id: :desc)
      @users = User.all
    end

    # Geocoder
    @geocoded_users = User.geocoded
    @markers = @geocoded_users.geocoded.map do |user|
>>>>>>> master
      {
        lat: user.latitude,
        lng: user.longitude,
        info_window: render_to_string(
          partial: "info_window",
          locals: { user: user }
        )
      }
    end

    # Because of this, index page card photos change, card info changes, raise doesn't work, etc. How to edit this ? <<<<<<<<<<<<<<
    # Stimulus controller (MUST be below Geocoder, otherwise markers won't show)
    @items_with_address = @items.map { |item| [item, item.user.address, @distances_between_other_users[item.user.id]] }

    respond_to do |format|
      format.html { render "items/index" }
      format.json { render json: @items_with_address }
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
        )
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
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def toggle_favorite
    current_user.favorited?(@item) ? current_user.unfavorite(@item) : current_user.favorite(@item)
  end

  def my_items
    @my_items = Item.where(user: current_user)
  end

  private

  def find_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :expiration_date, :status, :item_type, photos: [])
  end
end
