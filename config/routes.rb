Rails.application.routes.draw do
  # predictions routes
  get "/predictions/accuracy" => "predictions#accuracy"
  get "/prediction/:id" => "predictions#show"
end
