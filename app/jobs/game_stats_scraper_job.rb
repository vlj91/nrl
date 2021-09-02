class GameStatsScraperJob < ApplicationJob
  queue_as :default

  VALID_EVENT_TYPES = Rails.application.config_for(:nrl)[:valid_event_types]

  def game_url(round, home_team, away_team, season)
    # i'm sure there's a nicer way to do this..
    case round
    when 1..24
      round_title = "round-#{round}"
    when 25
      round_title = "grand-final"
    end

    "https://www.nrl.com/draw/nrl-premiership/#{season}/#{round_title}/#{home_team}-v-#{away_team}/"
  end

  def event_team_id(id, home_team, away_team)
    return home_team.id if home_team.nrl_id == id
    return away_team.id if away_team.nrl_id == id
  end

  def perform(*args)
    for game in Game.all.where(played: true, scraped: [false, nil]) do
      begin
        home_team = Team.find_by({id: game.home_team.team_id})
        away_team = Team.find_by({id: game.away_team.team_id})

        url = game_url(game.round, home_team.name, away_team.name, game.season)
        logger.info "Scraping #{url}"
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
          next unless VALID_EVENT_TYPES.include? event['type']

          GameEvent.find_or_create_by({
            event_type: event['type'],
            name: event['title'],
            game_id: game.id,
            player_id: Player.find_by(nrl_id: event['playerId']).id,
            team_id: Team.find_by(nrl_id: event['teamId']).id,
            description: event['description'],
            game_seconds: event['gameSeconds']
          })
        end

        game.scraped = true
        game.save!
      rescue => e
        logger.error("An error occurred: #{e}")
      end
    end
  end
end
