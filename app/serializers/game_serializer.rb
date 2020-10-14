class GameSerializer < ActiveModel::Serializer
  attributes :id, :round, :title, :stats
end
