teams = [
  { team_name: 'Storm', team_id: 500021 },
  { team_name: 'Bulldogs', team_id: 500010 },
  { team_name: 'Roosters', team_id: 500001 },
  { team_name: 'Rabbitohs', team_id: 500005 },
  { team_name: 'Wests Tigers', team_id: 500023 },
  { team_name: 'Cowboys', team_id: 500012 },
  { team_name: 'Titans', team_id: 500004 },
  { team_name: 'Panthers', team_id: 500014 },
  { team_name: 'Eels', team_id: 500031 },
  { team_name: 'Raiders', team_id: 500013 },
  { team_name: 'Dragons', team_id: 500022 },
  { team_name: 'Sharks', team_id: 500028 },
  { team_name: 'Broncos', team_id: 500011 },
  { team_name: 'Warriors', team_id: 500032 },
  { team_name: 'Knights', team_id: 500003 },
  { team_name: 'Sea Eagles', team_id: 500002 }
]

teams.each do |team|
  team = Team.create(name: team[:team_name], nrl_id: team[:team_id])
  puts "Created team: #{team}"
end