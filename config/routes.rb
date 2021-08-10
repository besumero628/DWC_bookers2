Rails.application.routes.draw do
  root to: 'homes#top'
  get "home/about" => "homes#about", as: :home_about

  devise_for :users

  resources :users, only: [:index, :show, :edit, :update] do
    # フォロー機能
    resources :relationships, only: [:create, :destroy]
    get "follower" => "relationships#follower", as: :relationships_follower
    get "followed" => "relationships#followed", as: :relationships_followed
    # DM機能
    resources :direct_messages, only: [:create, :destroy]
    get "chat" => "direct_messages#chat", as: :direct_messages_chat

  end

  resources :books, except: [:new] do
    resources :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :searches, only:[:index, :create]
  resources :groups

end
