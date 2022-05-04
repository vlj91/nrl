json.array! @games do |game|
  json.title game.title

  json.predictions do
    json.winner game.predicted_result
    json.margin game.predicted_win_margin
  end

  if game.played
    json.results do
      json.winner game.result
      json.margin game.win_margin
    end
  end
end
