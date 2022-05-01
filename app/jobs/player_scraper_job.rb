class PlayerScraperJob < ApplicationJob
  queue_as :default

  def perform(*args)
    for team in Team.all do
      doc = page_data("https://www.nrl.com/players/?team=#{team.nrl_id}", "div#vue-profile-search")

      for profile in doc['profileGroups'].first['profiles'] do
        Player.find_or_create_by({
          first_name: profile['firstName'],
          last_name: profile['lastName'],
          team_id: team.id
        })
      end
    end
  end
end
