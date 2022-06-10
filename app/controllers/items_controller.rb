class ItemsController < ApplicationController
  # a user doesn't have to log in to visit the index and show pages
  skip_before_action :authenticate_user!, only: :index
  # a user has to log in to like an item
  before_action :find_item, only: %i[show toggle_favorite]

  def index
    # Filter by postal code
    if params[:postal_code].present?
      # Filter users if items are near (5km)
      @users = User.near(params[:postal_code], 5)
      # Get all of these users items
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
      {
        lat: user.latitude,
        lng: user.longitude,
        info_window: render_to_string(
          partial: "info_window",
          locals: { user: user }
        )
      }
    end

    # Stimulus controller
    @items_with_address = @items.map  { | item| [item, item.user.address] }

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

  private

  def find_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :expiration_date, :status, :item_type, :allergen_ids, :diet_ids, photos: [])
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
end
