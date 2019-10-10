require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
require_relative '../lib/cell'
require 'pry'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    @cell_1 = Cell.new("B4")
    @cell_2 = Cell.new("C3")
    @cruiser = Ship.new('Cruiser', 3)
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

  def test_render_method
    assert_equal ".", @cell_1.render
  end

  def test_render_method_for_miss
    @cell_1.fire_upon
    assert_equal "M", @cell_1.render
  end

  def test_default_render_method_after_ship_placed
    @cell_2.place_ship(@cruiser)
    assert_equal ".", @cell_2.render
  end

  def test_check_render_argument
    assert_equal "S", @cell_2.render(true)
  end

  def test_render_for_hit
    @cell_2.place_ship(@cruiser)
    @cell_2.fire_upon
    assert_equal "H", @cell_2.render
  end

  def test_render_for_sunk_after_hit
    @cell_2.place_ship(@cruiser)
    @cell_2.fire_upon
    refute @cruiser.sunk?
  end

  def test_render_for_sunk
    @cell_2.place_ship(@cruiser)
    @cell_2.fire_upon
    @cruiser.hit
    @cruiser.hit
    assert @cruiser.sunk?
  end

  def test_render_after_sunk
    @cell_2.place_ship(@cruiser)
    @cell_2.fire_upon
    #binding.pry
    @cell_2.fire_upon
    #binding.pry
    @cell_2.fire_upon
    #binding.pry
    # @cruiser.hit
    # @cruiser.hit
    assert_equal "X", @cell_2.render
  end

end
