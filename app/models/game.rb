class Game < ApplicationRecord
  has_many :game_teams
  has_many :game_events

  def stats
    {
      winner: Team.find_by(id: home_team.team_id).name,
      highest_scoring_half: self.highest_scoring_half,
      first_try_scorer_team: Team.find_by(id: self.first_try_scorer_team_id).name,
      first_try_scorer_player: Player.find_by(id: self.first_try_scorer_player_id).full_name,
      first_try_minute: self.first_try_minute,
      first_half_tries: self.first_half_tries,
      second_half_tries: self.second_half_tries,
      winning_margin: self.winning_margin
    }
  end

  def home_team
    GameTeam.find_by(game_id: self.id, side: 'home')    
  end

  def away_team
    GameTeam.find_by(game_id: self.id, side: 'away')
  end

  def home_team_score
    home_team.score
  end

  def away_team_score
    away_team.score
  end

  def winning_margin
    if home_team_score >= away_team_score
      home_team_score - away_team_score
    elsif home_team_score <= away_team_score
      away_team_score - home_team_score
    end
  end

  def winner_id
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

  def first_try_scorer
    GameEvent.where(game_id: self.id, event_type: 'Try').order(:game_seconds).first
  end

  def first_try_scorer_team_id
    first_try_scorer.team_id
  end

  def first_try_scorer_player_id
    first_try_scorer.player_id
  end

  def first_try_minute
    first_try_scorer.game_seconds / 60
  end

  def first_half_tries
    GameEvent.where("game_id = :game_id AND event_type = :event_type AND game_seconds <= :game_seconds", {:game_id => self.id, :event_type => 'Try', :game_seconds => 2400}).length
  end

  def second_half_tries
    GameEvent.where("game_id = :game_id AND event_type = :event_type AND game_seconds >= :game_seconds", {:game_id => self.id, :event_type => 'Try', :game_seconds => 2401}).length
  end
end
