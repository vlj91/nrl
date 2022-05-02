json.array! @teams do |team|
  json.name team.name
  json.nickname team.nickname

  json.stats do
    for stat in team.team_stats
      json.set! stat.name.to_sym, stat.value
    end
  end
end
