class ResultModel < Eps::Base
  def build
    games = Game.all

    # train
    data = games.map { |v| features(v) }
    store = Model.where(key: 'price').first_or_initialize
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
      'home_team_avg_goals_per_game': TeamStat.find_by(team_id: home.team_id, name: 'avg_goals_per_game').value,
      'away_team_avg_goals_per_game': TeamStat.find_by(team_id: away.team_id, name: 'avg_goals_per_game').value,
      'home_team_avg_tries_per_game': TeamStat.find_by(team_id: home.team_id, name: 'avg_tries_per_game').value,
      'away_team_avg_tries_per_game': TeamStat.find_by(team_id: away.team_id, name: 'avg_tries_per_game').value,
      'home_team_avg_errors_per_game': TeamStat.find_by(team_id: home.team_id, name: 'avg_errors_per_game').value,
      'away_team_avg_errors_per_game': TeamStat.find_by(team_id: away.team_id, name: 'avg_errors_per_game').value,
      'home_team_avg_line_breaks_per_game': TeamStat.find_by(team_id: home.team_id, name: 'avg_line_breaks_per_game').value,
      'away_team_avg_line_breaks_per_game': TeamStat.find_by(team_id: away.team_id, name: 'avg_line_breaks_per_game').value,
      'home_team_avg_penalties_per_game': TeamStat.find_by(team_id: home.team_id, name: 'avg_penalties_per_game').value,
      'away_team_avg_penalties_per_game': TeamStat.find_by(team_id: away.team_id, name: 'avg_penalties_per_game').value,
      'result': game.result,
      'month': Time.parse(game.date).strftime("%b"),
      'day': Time.parse(game.date).strftime("%a"),
      'stadium': game.stadium,
      'city': game.city
    }
  end

  def model
    @model ||= begin
        data = Model.find_by({key: 'price'}).data
        Eps::Model.load_pmml(data)
    end
  end

  def model_file
    File.join(__dir__, 'result_model.pmml')
  end
end
