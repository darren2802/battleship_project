require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
require_relative '../lib/cell'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
  end

  # 1/3

  def test_does_it_exist
    assert_instance_of Cell, @cell
  end

  def test_cell_coordinate
    assert_equal "B4", @cell.coordinate
  end

  def test_ship
    assert_equal nil, @cell.ship
  end

  def test_cell_empty
    assert @cell.empty?
  end

  def test_place_ship
    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)
    assert_equal cruiser, @cell.ship
    refute @cell.empty?
  end

  # 2/3

  def test_ship_not_fired_upon
    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)
    refute @cell.fired_upon?
  end

  def test_ship_has_been_fired_upon_and_health
    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)
    @cell.fire_upon
    assert @cell.fired_upon?
    assert_equal 2, @cell.ship.health
  end

  # 3/3

  # ...

end
