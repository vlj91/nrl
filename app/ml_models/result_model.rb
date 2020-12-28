class ResultModel < Eps::Base
  def build
    games = Game.all

    for game in games do
      home_game_team = GameTeam.where(game_id: game.id, side: 'home')
    end

    data = games.map { |v| features(v) }
    model = Eps::Model.new(data, target: :result)
    File.write(model_file, model.to_pmml)
    @model = nil
  end

  def predict(game)
    model.predict(features(game))
  end

  private

  def features(game)
    {}
  end

  def model
    @model ||= Eps::Model.load_pmml(File.read(model_file))
  end

  def model_file
    File.join(__dir__, 'price_model.pmml')
  end
end
