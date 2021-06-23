Rails.application.routes.draw do
  resources :games

  mount ActionCable.server => '/cable'

end
