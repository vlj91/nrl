class TotalTriesModel < ApplicationModel
  def model_name
    'total_tries'
  end

  def accuracy(season: nil, round: nil)
    games = Game.where(played: true).load_async
    games = game.where(season: season) if season.present?
    games = game.where(round: round) if round.present?

    actual = games.map(&:total_tries)
    predicted = games.map(&:predicted_total_tries)
    Eps.metrics(actual, predicted)
  end

  def build
    games = Game.where(played: true).load_async
    data = games.map { |v| features(v) }
    store = Model.where(key: model_name).first_or_initialize
    model = Eps::Model.new(data, target: :total_tries, split: {validation_size: 0.25})
    store.update(data: model.to_pmml)
    print model.summary
    @model = nil
  end

  def features(game)
    features = base_game_features(game)

    features.merge!({
      total_tries: game.total_tries
    })

    return features
  end
end
