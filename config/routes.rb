Rails.application.routes.draw do

 devise_for :users

 root to: 'homes#top'

 get 'home/about' => 'homes#about', as: 'about'

  resources :books, only: [:new, :index, :show, :edit, :create, :update, :destroy]
  resources :users, only: [:edit, :index, :show, :update]

end
