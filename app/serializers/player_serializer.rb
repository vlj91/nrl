class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :position, :team_name, :stats
end
