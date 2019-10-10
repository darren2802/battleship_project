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
    @ship.hit if @ship
  end

  def fired_upon?
    @cell_has_been_fired_upon
  end

  def render(should_reveal=false)
    if should_reveal && @ship
      "S"
    elsif @cell_has_been_fired_upon && !@ship
      "M"
    elsif @cell_has_been_fired_upon && @ship && !@ship.sunk?
      "H"
    elsif @cell_has_been_fired_upon && @ship && @ship.sunk?
      "X"
    else
      "."
    end
  end

end
