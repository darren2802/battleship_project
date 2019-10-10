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
    cell_hash = @board.cells(height, width)

    assert_instance_of Hash, cell_hash
    assert_equal (height * width), cell_hash.length

    cell_hash.each_value do |hash_value|
      assert_instance_of Cell, hash_value
    end
  end

  def test_if_coordinate_is_valid
    @board.cells
    assert @board.valid_coordinate?("A1")
    assert @board.valid_coordinate?("D4")
  end

  def test_if_coordinate_is_invalid
    @board.cells
    refute @board.valid_coordinate?("A5")
    refute @board.valid_coordinate?("E1")
    refute @board.valid_coordinate?("A22")
  end

  def test_valid_placement_check_length
    # edge testing
    refute @board.valid_placement?(@cruiser, ["A1", "A2"])
    refute @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
  end

end
