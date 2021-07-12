Rails.application.routes.draw do
  resources :messages
  resources :users
  resources :game_cards
  resources :cards
  resources :games

  
  root  'games_controller#index' 
  mount ActionCable.server => '/cable'

end
