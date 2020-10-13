class GameEventsController < ApplicationController
  def show
    @game_event = GameEvent.find_by(params[:id])
    render :json => @game_event, :except => [:id, :created_at, :updated_at]
  end

  def list
    @game_events = GameEvent.all
    render :json => @game_events, :except => [:id, :created_at, :updated_at]
  end
end
