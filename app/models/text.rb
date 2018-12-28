class Text < ApplicationRecord
  scope :game_set, ->(length = 10) { order("RANDOM()").limit(length) }
end
