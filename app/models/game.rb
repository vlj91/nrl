# == Schema Information
#
# Table name: games
#
#  id                     :integer          not null, primary key
#  city                   :string
#  kickoff_time           :datetime
#  played                 :boolean
#  predicted_result       :string
#  predicted_total_points :integer
#  predicted_total_tries  :integer
#  predicted_win_margin   :integer
#  result                 :string
#  round                  :integer
#  scraped                :boolean
#  season                 :integer
#  stadium                :string
#  title                  :string
#  total_points           :integer
#  total_tries            :integer
#  win_margin             :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class Game < ApplicationRecord
  has_many :game_events
  has_many :game_stats
  has_many :players
  has_many :game_teams
  has_many :teams, through: :game_teams

  def away_team
    game_teams.find_by(side: 'away')
  end

  def home_team
    game_teams.find_by(side: 'home')
  end

  def home_team_events
    game_events.where(team_id: home_team.team_id)
  end

  def home_team_tries
    game_events.where(team_id: home_team.team_id, event_type: 'Try')
  end

  def home_team_goals
    game_events.where(team_id: home_team.team_id, event_type: 'Goal')
  end

  def home_team_one_point_field_goals
    game_events.where(team_id: home_team.team_id, event_type: 'OnePointFieldGoal')
  end

  def home_team_points
    ((home_team_tries.count * 4) + (home_team_goals.count * 2) + home_team_one_point_field_goals.count)
  end

  def away_team_events
    game_events.where(team_id: away_team.team_id)
  end

  def away_team_tries
    game_events.where(team_id: away_team.team_id, event_type: 'Try')
  end

  def away_team_goals
    game_events.where(team_id: away_team.team_id, event_type: 'Goal')
  end

  def away_team_one_point_field_goals
    game_events.where(team_id: away_team.team_id, event_type: 'OnePointFieldGoal')
  end

  def away_team_points
    ((away_team_tries.count * 4) + (away_team_goals.count * 2) + away_team_one_point_field_goals.count)
  end

  def team_first_try_scorer_name
    result = game_events.where(event_type: 'Try').order(:game_seconds)
    return nil if result.empty?
    return Team.find(result.first.team_id).name if result.length >= 1
  end

  def finals_round?
    self.round > Rails.application.config_for(:nrl)[:seasons].select {|x| x[:year] == self.season }.first[:last_regular_games_round]
  end
end
