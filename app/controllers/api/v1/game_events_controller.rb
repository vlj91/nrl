class Api::V1::GameEventsController < ApplicationController
  # /api/v1/game/events
  def index
    event = GameEvent.all
    event = event.where(game_id: params[:game_id]) if params[:game_id]
    event = event.where(event_type: params[:event_type]) if params[:event_type]
    event = event.where(team_id: params[:team_id]) if params[:team_id]
    event = event.where(player_id: params[:player_id]) if params[:player_id]
    event = event.where(description: params[:description]) if params[:description]
    event = event.order(params[:order]) if params[:order]
    event = event.limit(params[:limit]) if params[:limit]

    resp = { game_events: event }
    render json: resp
  end

  # /api/v1/game/events/:id
  def show
    game_event = GameEvent.find(params[:id])

    render json: game_event
  end
end
