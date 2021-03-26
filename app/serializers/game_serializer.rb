class GameSerializer
  include JSONAPI::Serializer
  attributes :city, :id, :kickoff_time, :predicted_result, :result, :round, :season, :stadium, :title
end
