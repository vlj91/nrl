Rails.application.routes.draw do
  get 'game/events/:id', to: 'game_events#show'
  get 'game/events', to: 'game_events#list'

  get 'games/:id', to: 'games#show'
  get 'games/:round/:title', to: 'games#show'
  get 'games', to: 'games#list'

  get 'teams/:id', to: 'teams#show'
  get 'teams', to: 'teams#list'

  get 'players/:id', to: 'players#show'
  get 'players', to: 'players#list'
end
