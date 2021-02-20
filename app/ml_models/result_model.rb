class ResultModel < Eps::Base
  def accuracy
    games = Game.all.where(played: true)
    actual = games.map(&:result)
    predicted = games.map(&:predicted_result)

    Eps.metrics(actual, predicted)
  end

  def build
    games = Game.all.where(played: true)

    # train
    data = games.map { |v| features(v) }
    store = Model.where(key: 'result').first_or_initialize
    model = Eps::Model.new(data, target: :result, split: {validation_size: 0.50})
    store.update(data: model.to_pmml)

    print model.summary

    # ensure reloads from db
    @model = nil
  end

  def predict(game)
    model.predict(features(game))
  end

  private

  def features(game)
    home = GameTeam.find_by(game_id: game.id, side: 'home')
    away = GameTeam.find_by(game_id: game.id, side: 'away')

    {
      # avg win margin
      'home_team_avg_win_margin': TeamStat.find_by(team_id: home.team_id, name: 'avg_win_margin').value,
      'away_team_avg_win_margin': TeamStat.find_by(team_id: away.team_id, name: 'avg_win_margin').value,

      # avg loss margin
      'home_team_avg_loss_margin': TeamStat.find_by(team_id: home.team_id, name: 'avg_loss_margin').value,
      'away_team_avg_loss_margin': TeamStat.find_by(team_id: away.team_id, name: 'avg_loss_margin').value,

      # avg goals per game
      'home_team_avg_goals_per_game': TeamStat.find_by(team_id: home.team_id, name: 'avg_goals_per_game').value,
      'away_team_avg_goals_per_game': TeamStat.find_by(team_id: away.team_id, name: 'avg_goals_per_game').value,

      # avg goals missed per game
      'home_team_avg_goals_missed_per_game': TeamStat.find_by(team_id: home.team_id, name: 'avg_goals_missed_per_game').value,
      'away_team_avg_goals_missed_per_game': TeamStat.find_by(team_id: away.team_id, name: 'avg_goals_missed_per_game').value,

      # avg tries per game
      'home_team_avg_tries_per_game': TeamStat.find_by(team_id: home.team_id, name: 'avg_tries_per_game').value,
      'away_team_avg_tries_per_game': TeamStat.find_by(team_id: away.team_id, name: 'avg_tries_per_game').value,

      # avg errors per game
      'home_team_avg_errors_per_game': TeamStat.find_by(team_id: home.team_id, name: 'avg_errors_per_game').value,
      'away_team_avg_errors_per_game': TeamStat.find_by(team_id: away.team_id, name: 'avg_errors_per_game').value,

      # avg line breaks per game
      'home_team_avg_line_breaks_per_game': TeamStat.find_by(team_id: home.team_id, name: 'avg_line_breaks_per_game').value,
      'away_team_avg_line_breaks_per_game': TeamStat.find_by(team_id: away.team_id, name: 'avg_line_breaks_per_game').value,

      # avg penalties per game
      'home_team_avg_penalties_per_game': TeamStat.find_by(team_id: home.team_id, name: 'avg_penalties_per_game').value,
      'away_team_avg_penalties_per_game': TeamStat.find_by(team_id: away.team_id, name: 'avg_penalties_per_game').value,

      # avg points per game
      'home_team_avg_points_per_game': TeamStat.find_by(team_id: home.team_id, name: 'avg_points_per_game').value,
      'away_team_avg_points_per_game': TeamStat.find_by(team_id: away.team_id, name: 'avg_points_per_game').value,

      # avg kick bombs per game
      'home_team_avg_kick_bombs_per_game': TeamStat.find_by(team_id: home.team_id, name: 'avg_kick_bombs_per_game').value,
      'away_team_avg_kick_bombs_per_game': TeamStat.find_by(team_id: away.team_id, name: 'avg_kick_bombs_per_game').value,

      # avg forty twenties per game
      'home_team_avg_forty_twenties_per_game': TeamStat.find_by(team_id: home.team_id, name: 'avg_forty_twenties_per_game').value,
      'away_team_avg_forty_twenties_per_game': TeamStat.find_by(team_id: away.team_id, name: 'avg_forty_twenties_per_game').value,

      # number of wins
      'home_team_wins': Team.find(home.team_id).wins,
      'away_team_wins': Team.find(away.team_id).wins,

      # number of draws
      'home_team_drawn': Team.find(home.team_id).draws,
      'away_team_drawn': Team.find(away.team_id).draws,

      # number of losses
      'home_team_losses': Team.find(home.team_id).losses,
      'away_team_losses': Team.find(away.team_id).losses,

      # number of home game wins
      'home_team_home_game_wins': Team.find(home.team_id).home_game_wins,
      'away_team_home_game_wins': Team.find(away.team_id).home_game_wins,

      # number of away game wins
      'home_team_away_game_wins': Team.find(home.team_id).away_game_wins,
      'away_team_away_game_wins': Team.find(away.team_id).away_game_wins,

      # features about the match not specific to a team
      'result': game.result,
      'month': Time.parse(game.date).strftime("%b"),
      'day': Time.parse(game.date).strftime("%a"),
      'stadium': game.stadium,
      'city': game.city
    }
  end

  def model
    @model ||= begin
        data = Model.find_by({key: 'result'}).data
        Eps::Model.load_pmml(data)
    end
  end

  def model_file
    File.join(__dir__, 'result_model.pmml')
  end
end
