require_relative './cell'

class Board

  def initialize
    @board_cells = {}
  end

  def cells(height=4, width=4)
    cell_hash = Hash.new
    height.times do |i|
      width.times do |j|
        hash_key = (i + 65).chr + (j + 1).to_s
        cell_hash[hash_key] = Cell.new(hash_key)
      end
    end
    @board_cells = cell_hash
    cell_hash
  end

  def valid_coordinate?(coordinate)
    @board_cells.has_key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    # check length of ship equals length of coordinate array
    return false if ship.length != coordinates.length

    # check that coordinates are consecutive
    
  end

end
