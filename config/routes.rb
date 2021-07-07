Rails.application.routes.draw do
  resources :game_cards
  resources :cards
  resources :games

  
  root  'games_controller#index' 
  mount ActionCable.server => '/cable'

end
