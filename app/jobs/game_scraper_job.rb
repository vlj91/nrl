class GameScraperJob < ApplicationJob
  DRAW_BASE_URL = 'https://www.nrl.com/draw/?competition=111&season=2020'

  queue_as :default

  def perform(*args)
    (1..23).each do |round|
      doc = page_data("#{DRAW_BASE_URL}&round=#{round}", "div#vue-draw")
      doc['fixtures'].each do |fixture|
        next if fixture['roundTitle'] == 'GrandFinal'
        next unless fixture['matchState'] == 'FullTime'

        home_team = Team.find_by(name: fixture['homeTeam']['nickName'])
        away_team = Team.find_by(name: fixture['awayTeam']['nickName'])

        game = Game.find_or_create_by({
          round: round,
          title: "#{home_team.slug}-v-#{away_team.slug}"
        })

        # create home team GameTeam
        GameTeam.find_or_create_by({
          game_id: game.id,
          team_id: home_team.id,
          side: 'home',
          score: fixture['homeTeam']['score']
        })

        GameTeam.find_or_create_by({
          game_id: game.id,
          team_id: away_team.id,
          side: 'away',
          score: fixture['awayTeam']['score']
        })
      end
    end
  end
end
