Rails.application.routes.draw do
  # predictions routes
  get "/predictions/accuracy" => "predictions#accuracy"
  get "/predictions/probability/:id" => "predictions#probability"
  get "/predictions/odds/:id" => "predictions#odds"
  get "/predictions/features" => "predictions#features"
  get "/predictions/:season/:round" => "predictions#round"
  get "/prediction/:id" => "predictions#show"
end
