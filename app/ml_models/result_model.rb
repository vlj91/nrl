class ResultModel < Eps::Base
  def build
    games = Game.all.where(predicted_result: nil)
    processed_games = []

    for game in games do
      processed_game = game.as_json

      for game_team in game.game_teams do
        processed_game["#{game_team.side}_team_avg_goals_per_game"] = TeamStat.find_by({
          name: 'avg_goals_per_game',
          team_id: game_team.team_id
        }).value

        processed_game["#{game_team.side}_team_avg_tries_per_game"] = TeamStat.find_by({
          name: 'avg_tries_per_game',
          team_id: game_team.team_id
        }).value

        processed_game["#{game_team.side}_team_avg_errors_per_game"] = TeamStat.find_by({
          name: 'avg_errors_per_game',
          team_id: game_team.team_id
        }).value

        processed_game["#{game_team.side}_team_avg_line_breaks_per_game"] = TeamStat.find_by({
          name: 'avg_line_breaks_per_game',
          team_id: game_team.team_id
        }).value

        processed_game.delete("id")
        processed_game.delete("date")
        processed_game.delete("created_at")
        processed_game.delete("updated_at")
        processed_game.delete("started_at")
      end

      processed_games.push(processed_game)
    end

    puts processed_games.first

    model = Eps::Model.new(processed_games, target: :result)

    return model
  end

  def predict(game)
    model.predict(features(game))
  end

  private

  def model
    @model ||= Eps::Model.load_pmml(File.read(model_file))
  end

  def model_file
    File.join(__dir__, 'result_model.pmml')
  end
end
