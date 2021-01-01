class GamePredictionUpdaterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    games = Game.all.where(predicted_result: nil)
    model = ResultModel.build

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

      game.predicted_result = model.predict(processed_game) 
      game.save!
    end
  end
end
