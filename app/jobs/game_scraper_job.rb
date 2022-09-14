class GameScraperJob < ApplicationJob
  queue_as :default

  NRL_COMP_ID = 111

  def draw_url(round, season)
    "https://nrl.com/draw/?competition=#{competition_id}&season=#{season}&round=#{round}"
  end

  def current_season_played_up_to_finals?(season)
    # returns true if no games in round 29 (final week of regular games)
    # has any unplayed matches.
    # we don't want to scrape games for finals, as the draw isn't
    # necessarily decided, and would be harder to reconcile later
    # in the season. by doing this, we can defer scraping those games.
    Game.where(season: season, round: 29, played: false).count == 0
  end

  def perform(*args)
    Rails.application.config_for(:nrl)[:seasons].each do |s|
      rounds = s[:last_regular_games_round] + 4

      for round in (1..rounds) do
        next unless current_season_played_up_to_finals?(s[:year])
        logger.info "Scraping games from round #{round} of season #{s[:year]}"
        doc = page_data(draw_url(round, s[:year]), 'div#vue-draw')
        logger.info "Found #{doc['fixtures'].length} games"

        for fixture in doc['fixtures'] do
          begin
           date = Date.parse(Time.parse(fixture['clock']['kickOffTimeLong']).to_s) 
           home_team = Team.find_by({nickname: fixture['homeTeam']['nickName']})
           away_team = Team.find_by({nickname: fixture['awayTeam']['nickName']})

           game = Game.find_or_create_by({
             season: s[:year],
             round: round,
             title: "#{home_team.name}-v-#{away_team.name}",
             stadium: fixture['venue'],
             city: fixture['venueCity'],
             kickoff_time: fixture['clock']['kickOffTimeLong'].to_datetime.in_time_zone("Australia/Sydney")
           })

          GameTeam.find_or_create_by({
            game_id: game.id,
            team_id: home_team.id,
            side: 'home'
          })

          GameTeam.find_or_create_by({
            game_id: game.id,
            team_id: away_team.id,
            side: 'away'
          })
          rescue => exception
            logger.error "An error occurred while scraping a game: #{exception.message}"
          end
        end
      end
    end
  end
end
