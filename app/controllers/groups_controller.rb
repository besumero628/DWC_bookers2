class GroupsController < ApplicationController

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
  
  
  private
  def group_params
    params.require(:group).permit(:name, :introduction, :group_image, :owner_id)
  end
  

end
