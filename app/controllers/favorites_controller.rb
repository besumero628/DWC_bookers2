class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:id])
    
  end
  
  def destroy
    @book = Book.find(params[:id])
  end
end
