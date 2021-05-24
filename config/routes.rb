Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/info" => "info#show"

      # ResultModel predictions routes
      get "/predictions/result/accuracy" => "result_model_predictions#accuracy"
      get "/predictions/result/probability/:id" => "result_model_predictions#probability"
      get "/predictions/result/odds/:id" => "result_model_predictions#odds"
      match "/predictions/result/:id" => "result_model_predictions#show", :via => [:get]

      # WinMarginModel predictions routes
      get "/predictions/win_margin/accuracy" => "win_margin_model_predictions#accuracy"
      match "/predictions/win_margin/:id" => "win_margin_model_predictions#show", :via => [:get]

      # TotalTriesModel predictions routes
      get "/predictions/total_tries/accuracy" => "total_tries_model_predictions#accuracy", :via => [:get]
      match "/predictions/total_tries/:id" => "total_tries_model_predictions#show", :via => [:get]

      # TotalPointsModel predictions routes
      get "/predictions/total_points/accuracy" => "total_points_model_predictions#accuracy", :via => [:get]
      match "/predictions/total_points/:id" => "total_points_model_predictions#show", :via => [:get]
      
      match "/games" => "games#index", :via => [:get]
      match "/games/:id" => "games#show", :via => [:get]

      match "/game/stats" => "game_stats#index", :via => [:get]
      match "/game/stats/:id" => "game_stats#show", :via => [:get]

      match "/game/events" => "game_events#index", :via => [:get]
      match "/game/events/:id" => "game_events#show", :via => [:get]

      match "/game/teams" => "game_teams#index", :via => [:get]
      match "/game/teams/:id" => "game_teams#show", :via => [:get]
    
      match "/players" => "players#index", :via => [:get]
      get "/players/:id" => "players#show"

      match "/player/stats" => "player_stats#index", :via => [:get]
      match "/player/stats/:id" => "player_stats#show", :via => [:get]
    
      match "/teams" => "teams#index", :via => [:get]
      get "/teams/:id" => "teams#show"

      match "/team/stats" => "team_stats#index", :via => [:get]
      match "/team/stats/:id" => "team_stats#show", :via => [:get]
    end
  end
end
