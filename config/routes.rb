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
      match "/games/:season/:round" => "games#find", :via => [:get]
    
      get "/players" => "players#index"
      get "/players/:id" => "games#show"
    
      get "/teams" => "teams#index"
      get "/teams/:id" => "teams#show"
    end
  end
end
