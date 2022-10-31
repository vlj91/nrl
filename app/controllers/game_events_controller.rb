class GameEventsController < ApplicationController
  def show
    @game_events = GameEvent.all
    @game_events = @game_events.where(event_type: params[:event_type]) if params[:event_type]
    @game_events = @game_events.where(team_id: params[:team_id]) if params[:team_id]
  end
end
