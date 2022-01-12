Rails.application.routes.draw do
  root "games#index"

  resources :players
  resources :games
  resources :teams
end
