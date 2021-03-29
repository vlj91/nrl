class ResultModel < ApplicationModel
  def accuracy(games)
    actual = games.map(&:result)
    predicted = games.map(&:predicted_result)

    Eps.metrics(actual, predicted)
  end

  def build
    games = Game.all.where(played: true)
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
