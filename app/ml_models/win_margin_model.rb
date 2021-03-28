class WinMarginModel < Eps::Base
  def accuracy(games)
    actual = games.map(&:win_margin)
    predicted = games.map(&:predicted_win_margin)

    Eps.metrics(actual, predicted)
  end

  def build
    # we want to sample on played games that have a result
    puts "Loading games"
    game = Game.where(played: true)

    puts "Mapping games with features"
    data = game.map { |v| features(v) }

    puts "Loading model from database"
    store = Model.where(key: 'win_margin').first_or_initialize

    puts "Initializing model"
    model = Eps::Model.new(data, target: :win_margin, split: {validation_size: 0.25})

    puts "Storing model"
    store.update(data: model.to_pmml)

    print model.summary

    # ensure model reloads from db
    @model = nil
  end

  def predict(game)
    model.predict(features(game))
  end

  def features(game)
    game_team = GameTeam.where(game_id: game.id)
    game_team_home = game_team.find_by(side: 'home')
    game_team_away = game_team.find_by(side: 'away')

    home_team = game_team_home.team
    away_team = game_team_away.team

    features = {
      # team names
      'home_team_name': home_team.name,
      'away_team_name': away_team.name,

      # number of wins
      'home_team_wins': home_team.wins,
      'away_team_wins': away_team.wins,

      # number of draws
      'home_team_drawn': home_team.draws,
      'away_team_drawn': away_team.draws,

      # number of losses
      'home_team_losses': home_team.losses,
      'away_team_losses': away_team.losses,

      # number of home game wins
      'home_team_home_game_wins': home_team.home_game_wins,
      'away_team_home_game_wins': away_team.home_game_wins,

      # number of away game wins
      'home_team_away_game_wins': home_team.away_game_wins,
      'away_team_away_game_wins': away_team.away_game_wins,

      # features about the match not specific to a team
      'result': game.result,
      'win_margin': game.win_margin,
      'month': game.kickoff_time.strftime("%b"),
      'day': game.kickoff_time.strftime("%a"),
      'stadium': game.stadium,
      'city': game.city
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
      data = Model.find_by({key: 'win_margin'}).data
      Eps::Model.load_pmml(data)
    end
  end

  def model_file
    File.join(__dir__, 'win_margin_model.pmml')
  end
end
