module Game
  class FuelStation < ::GameRecord
    self.table_name = "fuel"

    # Hand copied from game config.
    MAX_CAPACITY = 300.0

    def level_pct
      [((self.fuel / MAX_CAPACITY).round(2) * 100).floor, 100].min
    end
  end
end