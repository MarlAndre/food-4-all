class MessagesController < ApplicationController
  def create
    @request = Request.find(params[:request_id])
    @message = Message.new(message_params)
    @message.user = current_user
    @message.request = @request
    if @message.save
      RequestChannel.broadcast_to(
        @request,
        message: render_to_string(partial: "message", locals: { message: @message }),
        sender_id: @message.user.id
      )
      head :ok
    else
      render 'requests/show'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
