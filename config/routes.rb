Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get "/predictions/accuracy" => "predictions#accuracy"
      get "/predictions/probability/:id" => "predictions#probability"
      get "/predictions/odds/:id" => "predictions#odds"
      match "/predictions/features" => "predictions#features", :via => [:get]
      match "/predictions/:id" => "predictions#show", :via => [:get]
    
      get "/games" => "games#index"
      match "/games/:id" => "games#show", :via => [:get]

      match "/game/stats" => "game_stats#index", :via => [:get]
      match "/game/stats/:id" => "game_stats#show", :via => [:get]

      match "/game/events" => "game_events#index", :via => [:get]
      match "/game/events/:id" => "game_events#show", :via => [:get]

      match "/game/teams" => "game_teams#index", :via => [:get]
      match "/game/teams/:id" => "game_teams#show", :via => [:get]
    
      get "/players" => "players#index"
      get "/players/:id" => "games#show"
    
      get "/teams" => "teams#index"
      get "/teams/:id" => "teams#show"
    end
  end
end
