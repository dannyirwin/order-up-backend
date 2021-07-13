Rails.application.routes.draw do
  resources :messages, only: [:create]
  resources :users, only: [:index, :create]
  resources :games
  
  root  'games_controller#index' 
  mount ActionCable.server => '/cable'

end
