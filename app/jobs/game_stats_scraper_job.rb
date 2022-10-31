class GameStatsScraperJob < ApplicationJob
  queue_as :default

  def game_url(round, home_team, away_team, season)
    # i'm sure there's a nicer way to do this..
    case round
    when 1..25
      round_title = "round-#{round}"
      game_title = "#{home_team}-v-#{away_team}"
    when 26..28
      round_title = "finals-week-#{round-25}"
      game_title = "#{home_team}-v-#{away_team}"
    when 29
      round_title = "grand-final"
      game_title = "game-1"
    end

    "https://www.nrl.com/draw/nrl-premiership/#{season}/#{round_title}/#{game_title}/"
  end

  def event_team_id(id, home_team, away_team)
    home_team.nrl_id == id ? home_team.id : away_team.id
  end

  def perform(*args)
    for game in Game.all.where(played: true, scraped: [false, nil]) do
      begin
        home_team = Team.find_by({id: game.home_team.team_id})
        away_team = Team.find_by({id: game.away_team.team_id})

        url = game_url(game.round, home_team.name, away_team.name, game.season)
        doc = page_data(url, "div#vue-match-centre")['match']

        for team in ['homeTeam', 'awayTeam'] do
          # we should have previously scraped all players, but just in
          # case any were missed - this is also a good source
          # of players. as well as creating any missed players, we also
          # insert their NRL ID, which is often used throughout the site
          # in place of their name
          for player in doc[team]['players'] do
            team_id = team == 'homeTeam' ? home_team.id : away_team.id
            p = Player.find_or_create_by({
              first_name: player['firstName'],
              last_name: player['lastName'],
              team_id: team_id
            })

            p.nrl_id = player['playerId']
            p.save!
          end
        end

        for event in doc['timeline'] do
          if valid_event_types.include? event['type']
            GameEvent.find_or_create_by({
              event_type: event['type'],
              name: event['title'],
              game_id: game.id,
              player_id: Player.find_by(nrl_id: event['playerId']).id,
              team_id: Team.find_by(nrl_id: event['teamId']).id,
              description: event['description'],
              game_seconds: event['gameSeconds']
            })
          else
            Rails.logger.warn "Unhandled event type: #{event['type']}"
            next
          end
        end

        for group in doc['stats']['groups'] do
          for stat in group['stats'] do
            if valid_game_stat_types.pluck(:name).include? stat['title']
              for team in ['home', 'away'] do
                team_id = team == 'home' ? home_team.id : away_team.id
                GameStat.find_or_create_by({
                  name: valid_game_stat_types.find { |s| s[:name] == stat['title'] }[:id],
                  value: stat["#{team}Value"]['value'],
                  game_id: game.id,
                  team_id: team_id
                })
              end
            end
          end
        end

        game.scraped = true
        game.save!
      rescue => e
        logger.error("An error occurred: #{e}")
      end
    end
  end
end
