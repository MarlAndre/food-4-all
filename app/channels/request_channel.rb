class RequestChannel < ApplicationCable::Channel
  def subscribed
    # called when there is a new subscription
    request = Request.find(params[:id])
    stream_for request
    # stream_from "everyone"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
