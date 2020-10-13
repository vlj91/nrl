class GameStatsScraperJob < ApplicationJob
  queue_as :default

  def game_url(round, home_team, away_team)
    "https://www.nrl.com/draw/nrl-premiership/2020/round-#{round}/#{home_team}-v-#{away_team}/"
    "https://www.nrl.com/draw/nrl-premiership/2020/round-1/eels-v-bulldogs/"
    "https://www.nrl.com/draw/nrl-premiership/2020/round-1/storm-v-bulldogs/"
  end

  def perform(*args)
    Game.where(scraped: [false, nil]).each do |game|
      home_team = Team.find_by(id: game.home_team.id)
      away_team = Team.find_by(id: game.away_team.id)

      url = game_url(game.round, home_team.slug, away_team.slug)
      logger.info "URL: #{url}"
      doc = page_data(url, 'div#vue-match-centre')['match']

      doc['timeline'].each do |event|
      end
    end
  end
end
