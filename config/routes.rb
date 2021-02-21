Rails.application.routes.draw do
  resources :games, :players, :teams, :predictions, :player_stats, :team_stats, :game_events

  get "/prediction_accuracy" => "predictions#accuracy"
end
