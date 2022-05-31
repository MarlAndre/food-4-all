class ItemsController < ApplicationController
  before_action :find_item, only: %i[show]

  def index
    if params[:query].present?
      @items = Item.search_index(params[:query])
    else
      @items = Item.all.order(id: :desc)
      @items
    end

    # Filter by postal code
    if params[:postal_code].present?
      # Filter users if items are near (10km)
      @users = User.near(params[:postal_code], 5)
      # Get all of these users items
      @items = @users.map {|u| u.items}.flatten
    end


    # @markers = @users.items.geocoded.map do |user|
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

  private

  def find_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :expiration_date, :status, :item_type)
  end
end
