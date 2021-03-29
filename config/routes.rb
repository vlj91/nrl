Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :predictions do
        namespace :result do
          get "/accuracy" => "result_model_predictions#accuracy"
          get "/probability/:id" => "result_model_predictions#probability"
          get "/odds/:id" => "result_model_predictions#odds"
          match "/:id" => "result_model_predictions#show", :via => [:get]
        end

        namespace :margin do
          get "/accuracy" => "win_margin_model_predictions#accuracy"
          match "/:id" => "win_margin_model_predictions#show", :via => [:get]
        end
      end
      
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
