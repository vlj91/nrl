class ResultModel < Eps::Base
  def build
    # construct data to predict the winner of a game based on two teams statistics
    # {
    #   home_team_avg_errors_per_game: 11,
    #   home_team_avg_tries_per_game: 4,
    #   home_team_wins: 5,
    #   home_team_losses: 1,
    #   away_team_avg_errors_per_game: 14,
    #   away_team_avg_tries_per_game: 3,
    #   away_team_wins: 3,
    #   away_team_losses: 3
    # }
    
    games = Game.all

    # train the model
    data = games.map { |v| features(v) }
    model = Eps::Model.new(data, target: :result)
    File.write(model_file, model.to_pmml)
    @model = nil
  end
end
