class BooksController < ApplicationController

  def create
    book = Book.new(book_params)
    book.user_id = current_user.id
    if book.save
      flash.notice = "You have created book successfully."
      redirect_to user_path(params[:id])
    else
      @user = User.find(current_user.id)
      @book = book
      render template: "users/show"
    end
    
    
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
