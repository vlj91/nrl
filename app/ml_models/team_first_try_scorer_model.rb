class TeamFirstTryScorerModel < Eps::Base
  def features(game)
    home_team_game_team = GameTeam.find_by(game_id: game.id, side: 'home')
    away_team_game_team = GameTeam.find_by(game_id: game.id, side: 'away')
    home_team = Team.find(home_team_game_team.id)
    away_team = Team.find(away_team_game_team.id)

    features = {
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

    for stat in TeamStat.where(team_id: home.team_id) do
      features.merge!({"home_team_#{stat.name}": stat.value})
    end

    for stat in TeamStat.where(team_id: away_team.team_id) do
      features.merge!({"away_team_#{stat.name}": stat.value})
    end

    return features
  end
end