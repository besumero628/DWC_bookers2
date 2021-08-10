class GroupsController < ApplicationController

  before_action :ensure_current_user, {only: [:edit, :update]}

  def ensure_current_user
    if current_user.id != Group.find(params[:id]).owner_id
      flash.alert = "You cannot access!"
      redirect_to groups_path
    end
  end

  def index
    @user = current_user
    @book = Book.new

    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def show
    @user = current_user
    @book = Book.new
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      flash.notice = "You have created group successfully."
      redirect_to groups_path
    else
      render "new"
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      flash.notice = "You have updated group successfully."
      redirect_to groups_path
    else
      render action: :edit
    end
  end
  
  
  def join
    @group_user = GroupUser.new(user_id: current_user.id, group_id: params[:group_id])
    @group_user.save
    redirect_to groups_path
  end
  
  def leave
    @group_user = GroupUser.find_by(user_id: current_user.id, group_id: params[:group_id])
    @group_user.destroy
    redirect_to groups_path
  end


  private
  def group_params
    params.require(:group).permit(:name, :introduction, :group_image, :owner_id)
  end
  


end
