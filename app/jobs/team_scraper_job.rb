# TeamScraperJob collects the teams
# along with some basic info
class TeamScraperJob < ApplicationJob
  queue_as :default

  def perform(*args)
    page_url = "https://www.nrl.com/draw/"
    doc = page_data(page_url, "div#vue-draw")

    for fixture in doc['fixtures'] do
      for team in ['homeTeam', 'awayTeam'] do
        puts fixture[team]
        Team.find_or_create_by({
          name: fixture[team]['theme']['key'],
          nickname: fixture[team]['nickName'],
          nrl_id: fixture[team]['teamId']
        })
      end
    end
  end
end
