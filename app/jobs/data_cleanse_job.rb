class DataCleanseJob < ApplicationJob
  queue_as :default

  def perform(*args)
    TeamStat.delete_all
    PlayerStat.delete_all
    GameStat.delete_all
    GameEvent.delete_all
    GameTeam.delete_all
    Game.delete_all
    Player.delete_all
    Team.delete_all
  end
end
