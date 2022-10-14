# == Schema Information
#
# Table name: models
#
#  id         :integer          not null, primary key
#  data       :text
#  key        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_models_on_key  (key) UNIQUE
#
class Model < ApplicationRecord
end
