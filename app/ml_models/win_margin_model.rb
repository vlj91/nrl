class WinMarginModel < ApplicationModel
  def model_name
    'win_margin'
  end

  def accuracy(season: nil, round: nil)
    games = Game.where(played: true)
    games = games.where(season: season) if season.present?
    games = games.where(round: round) if round.present?

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
    features = base_game_features(game)
    features.merge!({'win_margin': game.win_margin})

    return features
  end
end
