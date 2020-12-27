require 'faker'

unless Team.all.length == 16
  16.times do
    Team.create(name: Faker::Sports::Football.team)
  end
end

Team.all.each do |team|
  unless team.players.length == 20
    20.times do
      Player.create({
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        team_id: team.id
      })
    end
  end
end

unless Game.all.length == 160
  Team.all.map(&:id).combination(2).to_a.each do |i|
    game = Game.create
  end
end
