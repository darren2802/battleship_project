require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
require_relative '../lib/cell'
require_relative '../lib/board'
require 'pry'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_does_it_exist

    assert_instance_of Board, @board
  end

  def test_cell_method
    height = 4
    width = 4
    cell_hash = @board.cells

    assert_instance_of Hash, cell_hash
    assert_equal (height * width), cell_hash.length

    cell_hash.each_value do |hash_value|
      assert_instance_of Cell, hash_value
    end
  end

  def test_if_coordinate_is_valid
    assert @board.valid_coordinate?("A1")
    assert @board.valid_coordinate?("D4")
  end

  def test_if_coordinate_is_invalid
    refute @board.valid_coordinate?("A5")
    refute @board.valid_coordinate?("E1")
    refute @board.valid_coordinate?("A22")
  end

  def test_valid_placement_check_length
    # edge testing
    refute @board.valid_placement?(@cruiser, ["A1", "A2"])
    refute @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
  end

  def test_coordinates_consecutive
    refute @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    assert @board.valid_placement?(@submarine, ["B1", "C1"])
    refute @board.valid_placement?(@submarine, ["A1", "C1"])
    refute @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    refute @board.valid_placement?(@submarine, ["C1", "A1"])
  end

  def test_coordinates_not_diagonal
    refute @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    refute @board.valid_placement?(@submarine, ["C2", "D3"])
  end

  def test_coordinates_valid
    assert @board.valid_placement?(@submarine, ["A1", "A2"])
    assert @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
  end

  def test_board_place_ship
    @board.place(@cruiser, ["A1", "A2", "A3"])
    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]
    cell_3 = @board.cells["A3"]

    assert_instance_of Ship, cell_1.ship
    assert_instance_of Ship, cell_2.ship
    assert_instance_of Ship, cell_3.ship
    assert cell_3.ship == cell_2.ship
  end

end
