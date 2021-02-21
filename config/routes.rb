Rails.application.routes.draw do
  # predictions routes
  get "/predictions/accuracy" => "predictions#accuracy"
  get "/predictions/probability/:id" => "predictions#probability"
  get "/predictions/odds/:id" => "predictions#odds"
  get "/prediction/:id" => "predictions#show"
end
