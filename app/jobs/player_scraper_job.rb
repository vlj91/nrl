class PlayerScraperJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Team.all.each do |team|
      document = page_data("https://www.nrl.com/players/?team=#{team.nrl_id}", "div#vue-profile-search")
      document['profileGroups'].first['profiles'].each do |profile|
        Player.find_or_create_by({
          first_name: profile['firstName'],
          last_name: profile['lastName'],
          team_id: team.id,
          position: profile['position']
        })
      end
    end
  end
end