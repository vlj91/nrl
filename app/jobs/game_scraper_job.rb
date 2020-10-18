class GameScraperJob < ApplicationJob
  DRAW_BASE_URL = 'https://www.nrl.com/draw/?competition=111&season=2020'

  queue_as :default

  def perform(*args)
    (1..23).each do |round|
      doc = page_data("#{DRAW_BASE_URL}&round=#{round}", "div#vue-draw")
      doc['fixtures'].each do |fixture|
        if fixture['roundTitle'] == 'GrandFinal'
          logger.info "grand final: #{fixture}"
        else
          logger.info "home team nickname: #{fixture['homeTeam']['nickName']}"
          home_team = Team.find_by(name: fixture['homeTeam']['nickName'])
          logger.info "away team nickname: #{fixture['awayTeam']['nickName']}"
          away_team = Team.find_by(name: fixture['awayTeam']['nickName'])

          next unless fixture['matchState'] == 'FullTime'

          game = Game.find_or_create_by({
            round: round,
            title: "#{home_team.slug}-v-#{away_team.slug}"
          })

          game_home_team = GameTeam.find_or_create_by({
            game_id: game.id,
            team_id: home_team.id,
            side: 'home',
            score: fixture['homeTeam']['score']
          })

          game_away_team = GameTeam.find_or_create_by({
            game_id: game.id,
            team_id: away_team.id,
            side: 'away',
            score: fixture['awayTeam']['score']
          })
        end
      end
    end
  end
end
