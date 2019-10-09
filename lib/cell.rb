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
    if @ship && @ship.sunk? == false
      @ship.hit
      @cell_symbol = "H"
    elsif @ship && @ship.sunk? == true #|| @ship.health == 0
      @cell_symbol = "X"
    else
      @cell_symbol = "M"
    end

  end

  def fired_upon?
    @cell_has_been_fired_upon
  end

  def render(argument=false)
    if argument == true
      "S"
    else
      @cell_symbol
    end
  end

end
