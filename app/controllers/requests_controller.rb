class RequestsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @requests = Request.all
  end

  # make sure only the current users can access the page, otherwise redirect.
  def show
    @request = Request.find(params[:id])
    if current_user == @request.giver || current_user == @request.receiver
      @message = Message.new
    else
      redirect_to item_path(@request.item)
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
end
