require_relative '.lib/cell'
require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

class CellTest < Minitest::Test

  def setup
    cell = Cell.new("B4")
  end

  def test_does_it_exist
    assert_instance_of Cell, cell
  end

  def test_cell_coordinate
    assert_equal "B4", cell.coordinate
  end

  def test_ship
    assert_equal nil, cell.ship
  end

  def test_cell_empty
    assert cell.empty?
  end

  def test_place_ship
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    assert_equal cruiser, cell.ship
    refute cell.empty?
  end

end
