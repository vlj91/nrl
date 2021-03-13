class AddRoundMatchNumberToGameJob < ApplicationJob
  queue_as :default

  def perform(*args)
    for season in Game.all.map(&:season).uniq do
      for round in Game.where(season: season).map(&:round).uniq do
        games = Game.where(season: season, round: round).order('date ASC')
        games.each_with_index do |game, index|
          game.round_match = index
          game.save!
        end
      end
    end
  end
end
