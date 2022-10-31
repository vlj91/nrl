class UpdateTotalWinsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Team.each do |team|
      stat = TeamStat.find_or_create_by({
        name: 'total_wins',
        team: team.id
      })

      wins = 0
      for i in team.game_teams do
        wins += 1 if i.game.result == i.side
      end

      stat.update!({
        value: wins
      })
    end
  end
end
