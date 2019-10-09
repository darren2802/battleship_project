require_relative './ship'

class Cell

  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @cell_has_been_fired_upon = false
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

  def fire_upon
    @cell_has_been_fired_upon = true
    @ship.hit
  end

  def fired_upon?
    @cell_has_been_fired_upon
  end

end
