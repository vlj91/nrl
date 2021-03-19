Rails.application.routes.draw do
  # /api/v1/predictions
  get "/api/v1/predictions/accuracy" => "predictions#accuracy"
  get "/api/v1/predictions/probability/:id" => "predictions#probability"
  get "/api/v1/predictions/odds/:id" => "predictions#odds"
  match "/api/v1/predictions/features" => "predictions#features", :via => [:get]
  match "/api/v1/predictions/:id" => "predictions#show", :via => [:get]

  # /api/v1/games
  get "/api/v1/games" => "games#index"
  match "/api/v1/games/:id" => "games#show", :via => [:get]
  match "/api/v1/games/:season/:round" => "games#find", :via => [:get]

  # players routes
  get "/api/v1/players" => "players#index"
  get "/api/v1/players/:id" => "games#show"

  # teams routes
  get "/api/v1/teams" => "teams#index"
  get "/api/v1/teams/:id" => "teams#show"
end
