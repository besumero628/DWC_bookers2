Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users

  resources :users, only: [:index, :show, :edit]
  resources :books, except: [:new]
end
