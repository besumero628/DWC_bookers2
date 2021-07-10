class BooksController < ApplicationController

  def index
    @user = User.find(current_user.id) #user info に表示したいuer
    @users = User.all #ページに表示したいbookのuser
    @book = Book.new #new book
    @books = Book.all #ページに表示したいbook
  end

  def show
     @book = Book.new
     @books = Book.find(params[:id])
     @user = User.find(@books.user_id)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    book = Book.new(book_params)
    book.user_id = current_user.id
    if book.save
      flash.notice = "You have created book successfully."
      redirect_to user_path(current_user.id) #books/showに変える
    else
      @user = User.find(current_user.id)
      @book = book
      render template: "users/show"
    end
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash.notice = "You have updated book successfully."
      redirect_to book_path(book.id)
    else
      @book = book
      render action: :edit
    end

  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash.notice = "You have destroyed book successfully."
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
