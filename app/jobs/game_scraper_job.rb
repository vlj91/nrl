class GameScraperJob < ApplicationJob
  queue_as :default

  NRL_COMP_ID = 111

  def draw_url(round, season)
    "https://nrl.com/draw/?competition=#{NRL_COMP_ID}&season=#{season}&round=#{round}"
  end


  def perform(*args)
    (2020..2021).each do |season|
      (1..23).each do |round|
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
            city: fixture['venueCity']
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
