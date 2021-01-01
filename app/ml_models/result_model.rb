class ResultModel < Eps::Base
  def build
    games = Game.all

    # train
    data = games.map { |v| features(v) }
    model = Eps::Model.new(data, target: :result)

    # save to file
    File.write(model_file, model.to_pmml)

    # ensure reloads from file
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
      'home_team_avg_goals_per_game': TeamStat.find_by(team_id: home.team_id, name: 'avg_goals_per_game').value,
      'away_team_avg_goals_per_game': TeamStat.find_by(team_id: away.team_id, name: 'avg_goals_per_game').value,
      'home_team_avg_tries_per_game': TeamStat.find_by(team_id: home.team_id, name: 'avg_tries_per_game').value,
      'away_team_avg_tries_per_game': TeamStat.find_by(team_id: away.team_id, name: 'avg_tries_per_game').value,
      'home_team_avg_errors_per_game': TeamStat.find_by(team_id: home.team_id, name: 'avg_errors_per_game').value,
      'away_team_avg_errors_per_game': TeamStat.find_by(team_id: away.team_id, name: 'avg_errors_per_game').value,
      'home_team_avg_line_breaks_per_game': TeamStat.find_by(team_id: home.team_id, name: 'avg_line_breaks_per_game').value,
      'away_team_avg_line_breaks_per_game': TeamStat.find_by(team_id: away.team_id, name: 'avg_line_breaks_per_game').value,
      'result': game.result,
      'month': Time.parse(game.date).strftime("%b"),
      'day': Time.parse(game.date).strftime("%a")
    }
  end

  def model
    @model ||= Eps::Model.load_pmml(File.read(model_file))
  end

  def model_file
    File.join(__dir__, 'result_model.pmml')
  end
end
