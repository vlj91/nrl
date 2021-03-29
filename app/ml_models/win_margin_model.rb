class WinMarginModel < ApplicationModel
  def model_name
    'win_margin'
  end

  def accuracy(games)
    actual = games.map(&:win_margin)
    predicted = games.map(&:predicted_win_margin)

    Eps.metrics(actual, predicted)
  end

  def build
    game = Game.where(played: true)
    data = game.map { |v| features(v) }
    store = Model.where(key: 'win_margin').first_or_initialize
    model = Eps::Model.new(data, target: :win_margin, split: {validation_size: 0.25})
    store.update(data: model.to_pmml)
    print model.summary
    @model = nil
  end

  def features(game)
    base_game_features(game)
  end
end
