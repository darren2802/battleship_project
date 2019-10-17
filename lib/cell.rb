require_relative './ship'

class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @cell_has_been_fired_upon = false
  end

  def empty?
    !@ship
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon
    @ship.hit if !empty? && !@cell_has_been_fired_upon
    @cell_has_been_fired_upon = true
  end

  def fired_upon?
    @cell_has_been_fired_upon
  end

  def render(should_reveal=false)
    if !empty? && should_reveal
      return "H" if fired_upon? && !@ship.sunk?
      return "X" if @ship.sunk?
    end

    #return "X" if should_reveal && @ship.sunk?
    return "S" if should_reveal && !empty?

    return "." if !fired_upon?
    return "M" if empty?

    if @ship.sunk?
      "X"
    else
      "H"
    end
  end
end
