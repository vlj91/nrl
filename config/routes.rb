Rails.application.routes.draw do
  resources :games, :players, :teams, :predictions

  get "/prediction_accuracy" => "predictions#accuracy"
end
