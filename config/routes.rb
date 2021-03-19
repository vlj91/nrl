Rails.application.routes.draw do
  # predictions routes
  get "/predictions/accuracy" => "predictions#accuracy"
  get "/predictions/probability/:id" => "predictions#probability"
  get "/predictions/odds/:id" => "predictions#odds"
  get "/predictions/features" => "predictions#features"
  get "/predictions/:season/:round" => "predictions#round"
  get "/prediction/:id" => "predictions#show"

  # games routes
  get "/games" => "games#index"
  match "games/:id" => "games#show", :via => [:get]
  match "games/:season/:round" => "games#find", :via => [:get]

  # players routes
  get "/players" => "players#index"
  get "/players/:id" => "games#show"

  # teams routes
  get "/teams" => "teams#index"
  get "/teams/:id" => "teams#show"
end
