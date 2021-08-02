class SearchesController < ApplicationController
  def index
    if params[:model] == "Book"

     if params[:searche_way] == "exact_match"
        @books = Book.where("title LIKE ?", "#{params[:searche_word]}").to_a
      elsif params[:searche_way] == "forward_match"
        @books = Book.where("title LIKE ?", "#{params[:searche_word]}%").to_a
      elsif params[:searche_way] == "backward_match"
        @books = Book.where("title LIKE ?", "%#{params[:searche_word]}").to_a
      elsif params[:searche_way] == "partial_match"
        @books = Book.where("title LIKE ?", "%#{params[:searche_word]}%").to_a
     end

    elsif params[:model] == "User"
      
      if params[:searche_way] == "exact_match"
        @users = User.where("name LIKE ?", "#{params[:searche_word]}").to_a
      elsif params[:searche_way] == "forward_match"
        @users = User.where("name LIKE ?", "#{params[:searche_word]}%").to_a
      elsif params[:searche_way] == "backward_match"
        @users = User.where("name LIKE ?", "%#{params[:searche_word]}").to_a
      elsif params[:searche_way] == "partial_match"
        @users = User.where("name LIKE ?", "%#{params[:searche_word]}%").to_a
     end
     
    end
  end

  private
  def searches_params
    params.permit(:searche_word, :model, :searche_way)
  end
end
