class Api::V1::GameEventsController < ApplicationController
  # /api/v1/game_events
  def index
    game_event = GameEvent.all

    render json: game_event
  end

  # /api/v1/game_events/game/:game_id
  def find
    game_event = GameEvent.where(game_id: game_id)

    render json: game_event
  end

  # /api/v1/game_events/:id
  def show
    game_event = GameEvent.find(params[:id])

    render json: game_event
  end
end