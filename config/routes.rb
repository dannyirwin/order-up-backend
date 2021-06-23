Rails.application.routes.draw do
  root  'games_controller#index' 
  resources :games
  mount ActionCable.server => '/cable'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
