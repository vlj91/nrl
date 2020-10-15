class GameSerializer < ActiveModel::Serializer
  attributes :title, :round, :stats
end
