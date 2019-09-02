class MessagesController < ApplicationController
  before_action :set_wedding

  def create
    message = Message.new(
      message_params.merge(user: current_user, read: false)
    )
    if message.save
      redirect_to redirection_path(message)
    end
  end

private

  def set_wedding
    @wedding = Wedding.find(params[:wedding_id])
  end

  def redirection_path(message)
    case message.resource_type
      when "Task"
        wedding_task_path(@wedding, message.resource)
      when "Discussion"
        wedding_discussion_path(@wedding, message.resource)
    end
  end

  def message_params
    params.require(:message).permit(:title, :content, :resource_id, :resource_type)
  end
end
