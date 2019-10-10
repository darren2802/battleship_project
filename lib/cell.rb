require_relative './ship'

class Cell

  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @cell_has_been_fired_upon = false
    @cell_symbol = "."
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

    if @ship == nil
      @cell_symbol = "M"
      return
    end

    @ship.hit

    if @ship.sunk?
      @cell_symbol = "X"
    else
      @cell_symbol = "H"
    end
  end

  def fired_upon?
    @cell_has_been_fired_upon
  end

  def render(should_reveal=false)
    if should_reveal
      "S"
    else
      @cell_symbol
    end
  end

end
