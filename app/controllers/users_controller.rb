class UsersController < ApplicationController
  before_action :ensure_current_user, {only: [:edit, :update]}
  
  def ensure_current_user
    @user_id = User.find(params[:id]).id
    if current_user.id != @user_id
      flash[:alert]="You cannot access!"
      redirect_to user_path(current_user.id)
    end
  end

  def index
    @user = User.find(current_user.id)
    @users = User.all
    @book = Book.new #new book
  end

  def show
    @user = User.find(params[:id])
    @users = User.all
    @book = Book.new
    @books = Book.where(user_id: params[:id])
    
    respond_to do |format|
      format.html {render "show"}
      format.js {render "book_search_result.js"}
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash.notice = "You have updated user successfully."
      redirect_to user_path(user.id)
    else
      @user = user
      render action: :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
