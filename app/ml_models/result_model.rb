class ResultModel < ApplicationModel
  def model_name
    'result'
  end

  def accuracy(season: nil, round: nil)
    games = Game.where(played: true).load_async # we can't show accuracy for games not played
    games = games.where(season: season) if season.present?
    games = games.where(round: round) if round.present?

    actual = games.map(&:result)
    predicted = games.map(&:predicted_result)
    Eps.metrics(actual, predicted)
  end

  def build
    games = Game.all.where(played: true).load_async
    data = games.map { |v| features(v) }
    store = Model.where(key: 'result').first_or_initialize
    model = Eps::Model.new(data, target: :result, split: {validation_size: 0.25})
    store.update(data: model.to_pmml)
    print model.summary
    @model = nil
  end

  def features(game)
    base_game_features(game)
  end
end
