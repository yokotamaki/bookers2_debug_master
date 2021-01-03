Rails.application.routes.draw do
  devise_for :users
  
  resources :users, only: [:show,:index,:edit,:update] do
    resource :relationships, only:[:create, :destroy] 
    get 'follower' => 'relationships#follower', as: 'follower'
    get 'followed' => 'relationships#followed', as: 'followed'
  end
  
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end  

  root 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'
end  