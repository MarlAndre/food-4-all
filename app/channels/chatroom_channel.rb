class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    # called when there is a new subscription
    chatroom = Chatroom.find(params[:id])
    stream_for chatroom
    # stream_from "everyone"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
