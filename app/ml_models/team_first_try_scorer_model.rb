class TeamFirstTryScorerModel < Eps::Base
  def build
    games = Game.all.where(played: true, result: ['draw', 'home', 'away'])

    # train
    data = games.map { |v| features(v) }
    store = Model.where(key: 'team_first_try_scorer').first_or_initialize
    model = Eps::Model.new(data, target: :first_team_try_scorer_team_name, split: {validation_size: 0.25})
    store.update(data: model.to_pmml)

    print model.summary

    # ensure reloads from db
    @model = nil
  end

  def predict(game)
    model.predict(features(game))
  end

  def features(game)
    home_team_game_team = GameTeam.find_by(game_id: game.id, side: 'home').load_async
    away_team_game_team = GameTeam.find_by(game_id: game.id, side: 'away').load_async
    home_team = Team.find(home_team_game_team.id).load_async
    away_team = Team.find(away_team_game_team.id).load_async

    features = {
      first_team_try_scorer_team_name: game.team_first_try_scorer_name,

      home_team_name: home_team.name,
      away_team_name: away_team.name,

      home_team_game_first_tries: home_team.game_first_tries,
      away_team_game_first_tries: away_team.game_first_tries,

      home_team_home_game_wins: home_team.home_game_wins,
      away_team_home_game_wins: away_team.home_game_wins,

      home_team_away_game_wins: home_team.away_game_wins,
      away_team_away_game_wins: away_team.away_game_wins,

      home_team_wins: home_team.wins,
      away_team_wins: away_team.wins,

      home_team_draws: home_team.draws,
      away_team_draws: away_team.draws,

      home_team_losses: home_team.losses,
      away_team_losses: away_team.losses,

      month: game.kickoff_time.strftime("%b"),
      day: game.kickoff_time.strftime("%a"),
      stadium: game.stadium,
      city: game.city,
    }

    for stat in home_team.team_stats do
      features.merge!({"home_team_#{stat.name}": stat.value})
    end

    for stat in away_team.team_stats do
      features.merge!({"away_team_#{stat.name}": stat.value})
    end

    return features
  end

  private

  def model
    @model ||= begin
        data = Model.find_by({key: 'team_first_try_scorer'}).data
        Eps::Model.load_pmml(data)
    end
  end

  def model_file
    File.join(__dir__, 'team_first_try_scorer_model.pmml')
  end
end