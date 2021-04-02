class TotalPointsModel < ApplicationModel
  def model_name
    'total_points'
  end

  def accuracy(season: nil, round: nil)
    games = Game.where(played: true)
    games = games.where(season: season) if season.present?
    games = games.where(round: round) if round.present?

    actual = games.map(&:result)
    predicted = games.map(&:predicted_result)
    Eps.metrics(actual, predicted)
  end

  def build
    games = Game.where(played: true)
    data = games.map { |v| features(v) }
    store = Model.where(key: model_name).first_or_initialize
    model = Eps::Model.new(data, target: :result, split: {validation_size: 0.25})
    store.update(data: model.to_pmml)
    print model.summary
    @model = nil
  end

  def features(game)
    features = base_game_features(game)
    features.merge!({
      total_points: game.total_points
    })

    return features
  end
end