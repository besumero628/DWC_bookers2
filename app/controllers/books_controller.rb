class BooksController < ApplicationController
  impressionist :actions=>[:show]

  before_action :ensure_current_user, {only: [:edit, :update]}

  def ensure_current_user
    @user_id = Book.find(params[:id]).user_id
    if current_user.id != @user_id
      flash.alert = "You cannot access!"
      redirect_to books_path
    end
  end

  def index
    @user = User.find(current_user.id) #user info に表示したいuer
    @book = Book.new #new book

    @books = Book.all

    if params[:search_category]
      @books = @books.find(search_category(@books, params[:search_category]))
    elsif params[:new_order_flag] == "true"
      @books = @books.all.order(created_at: :desc)
    elsif params[:rate_order_flag] == "true"
      bookrate_order(@books)
      @books = @books.find(@order_array).sort_by{ |o| @order_array.index(o.id)}
    else
      favorites_order(@books)
      @books = @books.find(@order_array).sort_by{ |o| @order_array.index(o.id)}
    end


  end

  def show
    @book = Book.new
    @book_detail = Book.find(params[:id])
    @book_comments = BookComment.where(book_id: @book_detail.id)
    @book_comment = BookComment.new
    @user = User.find(@book_detail.user_id)

    impressionist(@book_detail)

  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    book = Book.new(book_params)
    book.user_id = current_user.id
    if book.save
      flash.notice = "You have created book successfully."
      redirect_to book_path(book.id)
    else
      @user = User.find(current_user.id)
      @users = User.all
      @book = book
      @books = Book.all
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
    params.require(:book).permit(:title, :body, :category, :rate)
  end

  def bookrate_order(model)
    array = []
    model.each_with_index do |item, idx|
      array << [idx+1, item.rate]
    end

    array.sort! {|a,b| b[1] <=> a[1]}
    @order_array = array.map{|item| item[0]}
  end

  def favorites_order(model)
    array = []
    model.each_with_index do |item, idx|
      array << [idx+1, Favorite.where(book_id: item, created_at: 7.days.ago..Time.current).count]
    end

    array.sort! {|a,b| b[1] <=> a[1]}
    @order_array = array.map{|item| item[0]}
  end

  def search_category(model, category)
    search_category_array = Array.new
    model.each do |item|
      if item.has_category?(category)
        search_category_array << item.id
      end
    end
    return search_category_array
  end

end
