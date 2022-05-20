class ItemsController < ApplicationController
  before_action :find_item, only: %i[show]

  def index
    @items = Item.all.order(id: :desc)
  end

  def show; end

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
    params.require(:item).permit(:description, :expiration_date, :status, :item_type)
  end
end
