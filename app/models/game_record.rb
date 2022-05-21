class GameRecord < ApplicationRecord
  self.abstract_class = true

  connects_to database: { writing: :game, reading: :game }
end
