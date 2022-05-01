class TeamBadgeUrlJob < ApplicationJob
  queue_as :default

  def perform(*args)
    for team in Team.all do
      team.badge_url = "https://www.nrl.com/client/dist/logos/#{team.name}-badge.svg"
      team.save!
    end
  end
end
