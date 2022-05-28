class RequestsController < ApplicationController
  def index
    @requests = Request.all
  end

  def show
    @request = Request.find(params[:id])
    @message = Message.new
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
