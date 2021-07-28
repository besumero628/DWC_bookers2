Rails.application.routes.draw do
  root to: 'homes#top'
  get "home/about" => "homes#about", as: :home_about
  
  devise_for :users

  resources :users, only: [:index, :show, :edit, :update]
  resources :books, except: [:new] do
    resources :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
end
