Rails.application.routes.draw do
  resources :games, :players, :teams, :predictions
  get "/games", to: "games#list"
  get "/players", to: "players#list"
  get "/teams", to: "teams#list"
  get "/predictions/:id", to: "predictions#get"
end
