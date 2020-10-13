class GameEventsController < ApplicationController
  def show
    @game_event = GameEvent.find_by(params[:id])
    render json: @game_event.to_json
  end

  def list
    @game_events = GameEvent.all
    render json: @game_events.to_json
  end
end
