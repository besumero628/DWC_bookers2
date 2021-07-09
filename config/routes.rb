Rails.application.routes.draw do
  root to: 'homes#top'
  get "homes/about" => "homes#about", as: :homes_about
  
  devise_for :users

  resources :users, only: [:index, :show, :edit, :update]
  resources :books, except: [:new]
end
