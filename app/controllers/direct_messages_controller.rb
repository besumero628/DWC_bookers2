class DirectMessagesController < ApplicationController
  before_action :ensure_current_user, only: :chat
  before_action :messages_order, only: :chat

  def chat
    @receive_user = User.find(params[:user_id])
    @direct_messages = DirectMessage.find(@order_array).sort_by{ |o| @order_array.index(o.id)}
    @direct_message = DirectMessage.new
  end

  def create
    @direct_message = DirectMessage.new(direct_message_params)
    @direct_message.send_user_id = current_user.id
    @direct_message.receive_user_id = params[:user_id]

    if @direct_message.save
      redirect_to user_direct_messages_chat_path(params[:user_id])
    else
      ensure_current_user
      messages_order
      @receive_user = User.find(params[:user_id])
      @direct_messages = DirectMessage.find(@order_array).sort_by{ |o| @order_array.index(o.id)}
      render "chat"
    end
  end

  private
  def ensure_current_user
    @send_user = User.find(current_user.id)
    @receive_user = User.find(params[:user_id])

    if !@send_user.mutual_follow?(@receive_user)
      flash.alert = "You cannot access!"
      redirect_back(fallback_location: root_path)
    end
  end

  def direct_message_params
    params.require(:direct_message).permit(:message)
  end

  def messages_order
    array = []
    DirectMessage.all.each do |item|
      if (item.send_user_id == @send_user.id) || (item.send_user_id == @receive_user.id)
        if (item.receive_user_id == @send_user.id) || (item.receive_user_id == @receive_user.id)
          array << [item.id, item.created_at]
        end
      end
    end

    array.sort! {|a,b| a[1] <=> b[1]}
    @order_array = array.map{|item| item[0]}
  end

end
