Rails.application.routes.draw do
  defaults format: :json do
    resources :games
    resources :teams

    get 'stats', to: 'stats#index'
  end
end
