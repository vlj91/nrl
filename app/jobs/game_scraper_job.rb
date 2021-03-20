class GameScraperJob < ApplicationJob
  queue_as :default

  NRL_COMP_ID = 111
  CURRENT_SEASON = 2021

  def draw_url(round, season)
    "https://nrl.com/draw/?competition=#{NRL_COMP_ID}&season=#{season}&round=#{round}"
  end

  def current_season_played_up_to_finals?(season)
    # returns true if no games in round 19 (final week of regular games)
    # has any unplayed matches.
    # we don't want to scrape games for finals, as the draw isn't
    # necessarily decided, and would be harder to reconcile later
    # in the season. by doing this, we can defer scraping those games.
    Game.where(season: season, round: 19, played: false).count == 0
  end

  def perform(*args)
    (2020..2021).each do |season|
      (1..24).each do |round|
        next unless current_season_played_up_to_finals?(season)
        logger.info "Scraping games from round #{round}, season #{season}"

        # load the games for the current round
        doc = page_data(draw_url(round, season), 'div#vue-draw')
        logger.info "Found #{doc['fixtures'].length} games to scrape"

        for fixture in doc['fixtures'] do
          date = Date.parse(Time.parse(fixture['clock']['kickOffTimeLong']).to_s)
          home_team = Team.find_by({nickname: fixture['homeTeam']['nickName']})
          away_team = Team.find_by({nickname: fixture['awayTeam']['nickName']})

          game = Game.find_or_create_by({
            date: date,
            round: round,
            season: season,
            title: "#{home_team.name}-v-#{away_team.name}",
            stadium: fixture['venue'],
            city: fixture['venueCity'],
            kickoff_time: fixture['clock']['kickOffTimeLong'].to_datetime.in_time_zone("Sydney")
          })

          game_home_team = GameTeam.find_or_create_by({
            game_id: game.id,
            team_id: home_team.id,
            side: 'home'
          })

          game_away_team = GameTeam.find_or_create_by({
            game_id: game.id,
            team_id: away_team.id,
            side: 'away'
          })
        end
      end
    end
  end
end
