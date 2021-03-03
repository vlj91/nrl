Rails.application.routes.draw do
  # predictions routes
  get "/predictions/accuracy" => "predictions#accuracy"
  get "/predictions/probability/:id" => "predictions#probability"
  get "/predictions/odds/:id" => "predictions#odds"
  get "/predictions/features" => "predictions#features"
  get "/predictions/:season/:round" => "predictions#round"
  get "/prediction/:id" => "predictions#show"

  # games routes
  get "/games" => "games#list"
  match "games/:id" => "games#show"
  match "games/:season/:round" => "games#find"

  # players routes
  get "/players" => "players#list"
  get "/players/:id" => "games#show"

  # teams routes
  get "/teams" => "teams#list"
  get "/teams/:id" => "teams#show"
end
