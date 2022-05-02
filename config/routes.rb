Rails.application.routes.draw do
  defaults format: :json do
    resources :games
    resources :teams
  end
end
