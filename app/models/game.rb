class Game < ApplicationRecord
  has_many :game_teams
  has_many :game_events
  has_many :game_stats

  def away_team
    GameTeam.find_by(game_id: self.id, side: 'away')
  end

  def home_team
    GameTeam.find_by(game_id: self.id, side: 'home')
  end

  def home_team_events
    GameEvent.where(game_id: self.id, team_id: home_team.team_id)
  end

  def home_team_tries
    GameEvent.where(game_id: self.id, team_id: home_team.team_id, event_type: 'Try')
  end

  def home_team_goals
    GameEvent.where(game_id: self.id, team_id: home_team.team_id, event_type: 'Goal')
  end

  def home_team_points
    ((home_team_tries.count * 4) + (home_team_goals.count * 2))
  end

  def away_team_events
    GameEvent.where(game_id: self.id, team_id: away_team.team_id)
  end

  def away_team_tries
    GameEvent.where(game_id: self.id, team_id: away_team.team_id, event_type: 'Try')
  end

  def away_team_goals
    GameEvent.where(game_id: self.id, team_id: away_team.team_id, event_type: 'Goal')
  end

  def away_team_points
    ((away_team_tries.count * 4) + (away_team_goals.count * 2))
  end

  def result
    if home_team_points > away_team_points
      return 'home'
    elsif away_team_points > home_team_points
      return 'away'
    elsif home_team_points == away_team_points
      return 'draw'
    end
  end
end
