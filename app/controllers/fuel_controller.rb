class FuelController < ApplicationController
  def show
    @stations = Game::FuelStation.all
  end
end
