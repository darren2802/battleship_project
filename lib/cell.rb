require_relative '../lib/ship'

class Cell

  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
  end

  def empty?
    if @ship
      false
    else
      true
    end
  end

  def place_ship(ship)
    @ship = ship
  end

end
