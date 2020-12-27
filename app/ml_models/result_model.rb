class ResultModel < Eps::Base
  def build
    games = Game.all
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
    home_game_team = GameTeam.where(game_id: self.id, side: 'home')
    home_team = Team.where(id: home_game_team.team_id)

    # todo merge team.stats with prefixed key
    {
      home_team_avg_errors_per_game: home_team.avg_errors_per_game,
      home_team_avg_tries_per_game: home_team.avg_tries_per_game,
      away_team_avg_errors_per_game: away_team.avg_errors_per_game,
      away_team_avg_tries_per_game: away_team.avg_tries_per_game,
      result: game.result
    }
  end

  def model
    @model ||= Eps::Model.load_pmml(File.read(model_file))
  end

  def model_file
    File.join(__dir__, 'price_model.pmml')
  end
end
