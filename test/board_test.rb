require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
require_relative '../lib/cell'
require_relative '../lib/board'
require 'pry'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
  end

  def test_does_it_exist

    assert_instance_of Board, @board
  end

  def test_cell_method
    cell_hash = @board.cells
    assert_instance_of Hash, cell_hash
    assert_equal 16, cell_hash.length

    cell_hash.each_value do |hash_value|
      assert_instance_of Cell, hash_value
    end
  end

  def test_if_coordinate_is_valid
    skip
    assert @board.valid_coordinate?("A1")
    assert @board.valid_coordinate?("D4")
  end

  def test_if_coordinate_is_invalid
    skip
    refute @board.valid_coordinate?("A5")
    refute @board.valid_coordinate?("E1")
    refute @board.valid_coordinate?("A22")
  end



end
