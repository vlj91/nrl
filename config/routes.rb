Rails.application.routes.draw do
  resources :games, :players, :teams, :predictions
end
