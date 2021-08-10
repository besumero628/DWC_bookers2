class EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event =Event.new(event_params)
    @event.group_id = params[:group_id]

    @owner = User.find(Group.find(params[:group_id]).owner_id)
    @users = Group.find(params[:group_id]).users

    if @event.save
      @users.each do |user|
        EventMailer.event_mail(@owner, user, @event.message).deliver_now
      end
      flash.notice = "You have created event message successfully."
      redirect_to group_event_path(group_id: params[:group_id], id: @event.id)
    else
      render "new"
    end

  end

  private
  def event_params
    params.require(:event).permit(:subject, :message)
  end

end
