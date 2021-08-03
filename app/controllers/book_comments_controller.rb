class BookCommentsController < ApplicationController
  def create
    @book = Book.new

    @book_detail = Book.find(params[:book_id])
    @user = User.find(@book_detail.user_id)
    @book_comments = BookComment.where(book_id: @book_detail.id)

    @book_comment = BookComment.new(book_comment_params)
    @book_comment.user_id = current_user.id
    @book_comment.book_id = params[:book_id]
    @book_comment.save

    @new_book_comment = BookComment.new
  end

  def destroy
    book_comment = BookComment.find_by(user_id: current_user.id, book_id: params[:book_id])
    book_comment.destroy

    @book_detail = Book.find(params[:book_id])
    @user = User.find(@book_detail.user_id)
    @book_comments = BookComment.where(book_id: @book_detail.id)
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
