class GameScraperJob < ApplicationJob
  queue_as :default

  DRAW_BASE_URL = 'https://nrl.com/draw/?competition=111&season=2020' # TODO: allow filtering by year

  def perform(*args)

    (1..23).each do |round|
      doc = page_data("#{DRAW_BASE_URL}&round=#{round}", "div#vue-draw")

      for fixture in doc['fixtures'] do
        next if fixture['roundTitle'] == 'GrandFinal' # not interested
        home_team = Team.find_by({nickname: fixture['homeTeam']['nickName']})
        away_team = Team.find_by({nickname: fixture['awayTeam']['nickName']})

        game = Game.find_or_create_by({
          round: round,
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
