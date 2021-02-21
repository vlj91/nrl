class ResultModel < Eps::Base
  def accuracy
    games = Game.all.where(played: true)
    actual = games.map(&:result)
    predicted = games.map(&:predicted_result)

    Eps.metrics(actual, predicted)
  end

  def probability(game)
    model.predict_probability(features(game))
  end

  def build
    games = Game.all.where(played: true)

    # train
    data = games.map { |v| features(v) }
    store = Model.where(key: 'result').first_or_initialize
    model = Eps::Model.new(data, target: :result, split: {validation_size: 0.25})
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
    # cache team results for current game, they get used a lot
    home ||= GameTeam.find_by(game_id: game.id, side: 'home')
    away ||= GameTeam.find_by(game_id: game.id, side: 'away')
    home_team ||= Team.find(home.team_id)
    away_team ||= Team.find(away.team_id)

    features = {
      # number of wins
      'home_team_wins': home_team.wins,
      'away_team_wins': away_team.wins,

      # number of draws
      'home_team_drawn': home_team.draws,
      'away_team_drawn': away_team.draws,

      # number of losses
      'home_team_losses': home_team.losses,
      'away_team_losses': away_team.losses,

      # number of home game wins
      'home_team_home_game_wins': home_team.home_game_wins,
      'away_team_home_game_wins': away_team.home_game_wins,

      # number of away game wins
      'home_team_away_game_wins': home_team.away_game_wins,
      'away_team_away_game_wins': away_team.away_game_wins,

      # features about the match not specific to a team
      'result': game.result,
      'month': Time.parse(game.date).strftime("%b"),
      'day': Time.parse(game.date).strftime("%a"),
      'stadium': game.stadium,
      'city': game.city
    }

    for stat in TeamStat.where(team_id: home.team_id) do
      features.merge!({"home_team_#{stat.name}": stat.value})
    end

    for stat in TeamStat.where(team_id: away.team_id) do
      features.merge!({"away_team_#{stat.name}": stat.value})
    end

    return features
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
