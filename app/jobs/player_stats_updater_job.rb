class PlayerStatsUpdaterJob < ApplicationJob
  queue_as :default

  def update_avg_try_minute!(player)
    try_seconds = GameEvent.where(player_id: player.id, event_type: 'Try').map(&:game_seconds)

    stat = PlayerStat.find_or_create_by({
      player_id: player.id,
      name: 'avg_try_minute'
    })

    stat.value = try_seconds.sum.fdiv(try_seconds.size) / 60
    stat.save!
  end

  def update_total_tries!(player)
    stat = PlayerStat.find_or_create_by({
      player_id: player.id,
      name: 'total_tries'
    })

    stat.value = GameEvent.where(player_id: player.id, event_type: 'Try').count
    stat.save!
  end

  def update_avg_tries_per_game!(player)
    stat = PlayerStat.find_or_create_by({
      player_id: player.id,
      name: 'avg_tries_per_game'
    })

    tries = []
    game_ids = GameTeam.where(team_id: player.team_id).map(&:game_id)
    games = Game.where(id: game_ids)

    for game in games do
      tries.push(game.game_events.where(team_id: player.team_id, player_id: player.id, event_type: 'Try').count)
    end

    stat.value = tries.sum.fdiv(tries.size).round(0)
    stat.save!
  end

  def perform(*args)
    for player in Player.all do
      update_avg_try_minute!(player)
      update_avg_tries_per_game!(player)
      update_total_tries!(player)
    end
  end
end
