class PlayerScraperJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Team.all.each do |team|
      document = page_data("https://www.nrl.com/players/?team=#{team.nrl_id}", "div#vue-profile-search")
      document['profileGroups'].first['profiles'].each do |profile|
        player_params = {
          first_name: profile['firstName'],
          last_name: profile['lastName'],
          team_id: Team.find_by(name: profile['teamNickName']).id,
          position: profile['position']
        }

        player = Player.find_by(player_params)
        if player.nil?
          Player.create(player_params)
        end
      end
    end
  end
end