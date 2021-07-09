class UsersController < ApplicationController
  
  def index
    @user = User.find(current_user.id)
    @users = User.all
    @book = Book.new #new book
  end
  
  def show
    @user = User.find(params[:id])
    @users = User.all
    @book = Book.new
    @books = Book.where(user_id: current_user.id)
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
end
