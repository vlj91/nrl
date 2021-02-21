namespace :scheduler do
  desc "Run daily job"
  task :daily => :environment do
    DailyJob.perform_now
  end
end
