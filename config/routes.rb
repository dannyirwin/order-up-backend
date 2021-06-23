Rails.application.routes.draw do
  resources :games

  root  'games_controller#index' 

  mount ActionCable.server => '/cable'

end
