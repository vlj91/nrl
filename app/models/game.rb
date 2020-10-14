class Game < ApplicationRecord
  has_many :game_teams
  has_many :game_events

  def stats
    {
      winner: Team.find_by(id: home_team.team_id).name,
      highest_scoring_half: self.highest_scoring_half,
      first_try_scorer_team: Team.find_by(id: self.first_try_scorer_team_id).name,
      first_try_scorer_player: Player.find_by(id: self.first_try_scorer_player_id).last_name
    }
  end

  def home_team
    GameTeam.find_by(game_id: self.id, side: 'home')    
  end

  def away_team
    GameTeam.find_by(game_id: self.id, side: 'away')
  end

  def winner_id
    logger.info "home #{home_team.score} v #{away_team.score} away"
  
    if home_team.score == away_team.score
      return nil
    elsif home_team.score > away_team.score
      return home_team.team_id
    elsif away_team.score > home_team.score
      return away_team.team_id
    end
  end

  def loser_id
    if home_team.score == away_team.score
      return nil
    elsif home_team.score > away_team.score
      return away_team.team_id
    elsif away_team.score > home_team.score
      return home_team.team_id
    end
  end

  def highest_scoring_half
    tries = GameEvent.where(game_id: self.id, event_type: 'Try').map(&:game_seconds).sort
    first_half_tries = tries.select { |i| i < 2400 }
    second_half_tries = tries.select { |i| i > 2400 }

    first_half_tries.length > second_half_tries.length ? 1 : 2
  end

  def first_try_scorer_team_id
    GameEvent.where(game_id: self.id, event_type: 'Try').order(:game_seconds).first.team_id
  end

  def first_try_scorer_player_id
    GameEvent.where(game_id: self.id, event_type: 'Try').order(:game_seconds).first.player_id
  end
end
