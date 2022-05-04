Rails.application.routes.draw do
  defaults format: :json do
    resources :games
    resources :teams

    get 'stats', to: 'stats#index'
    get 'tips/:season/:round', to: 'tips#index'
  end
end
