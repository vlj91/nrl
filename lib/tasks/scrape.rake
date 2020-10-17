namespace :scrape do
  desc "Run game scraper job"
  task games: :environment do
    GameScraperJob.perform_now
  end

  desc "Run game stats scraper job"
  task game_stats: :environment do
    GameStatsScraperJob.perform_now
  end

  desc "Run players scraper job"
  task players: :environment do
    PlayerScraperJob.perform_now
  end
end
