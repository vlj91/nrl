class ApplicationModel < Eps::Base
  def probability(item)
    model.predict_probability(features(item))
  end

  # use the model to predict the outcome of the provided item
  def predict(item)
    model.predict(features(item))
  end

  # a set of basic features that can be used for a
  # model that predicts on Game
  def base_game_features(game)
    game_teams = GameTeam.where(game_id: game.id)
    game_team_home = game_teams.find_by(side: 'home')
    game_team_away = game_teams.find_by(side: 'away')

    home_team = game_team_home.team
    away_team = game_team_away.team

    features = {
      # team names
      'home_team_name': home_team.name,
      'away_team_name': away_team.name,

      # number of WDL by team
      'home_team_wins': home_team.wins,
      'away_team_wins': away_team.wins,
      'home_team_draws': home_team.draws,
      'away_team_draws': away_team.draws,
      'home_team_losses': home_team.losses,
      'away_team_losses': away_team.losses,

      # features related to the game, not specific to a team
      'result': game.result,
      'month': game.kickoff_time.strftime("%b"),
      'day': game.kickoff_time.strftime("%a"),
      'season': game.season,
      'round': game.round,
      'stadium': game.stadium,
      'city': game.city
    }

    # load in all stats related to each team
    for stat in home_team.team_stats do
      features.merge!({"home_team_#{stat.name}": stat.value})
    end

    for stat in away_team.team_stats do
      features.merge!({"away_team_#{stat.name}": stat.value})
    end

    return features
  end

  private

  # define model_name method which simply returns the name/key
  def model
    @model ||= begin
      data = Model.find_by({ key: model_name }).data
      Eps::Model.load_pmml(data)
    end
  end

  def model_file
    File.join(__dir__, "#{model_name}_model.pmml")
  end
end
