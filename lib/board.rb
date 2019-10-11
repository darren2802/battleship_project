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

    # get the ascii numbers of the letters of the coordinates
    coord_letters_ascii = coordinates.map { |coordinate| coordinate.slice(0,1).ord }
    # get the numbers of the coordinates
    coord_numbers = coordinates.map { |coordinate| coordinate.slice(1,1).ord }

    # test if valid row (letters the same and numbers consecutive)
    return true if numbers_equal?(coord_letters_ascii) && numbers_consecutive?(coord_numbers)

    # test if valid column (letters consecutive but numbers the same)
    return true if numbers_consecutive?(coord_letters_ascii) && numbers_equal?(coord_numbers)

    # if coordinates are neither a proper row or column then false will be returned as the last resort
  end

  def numbers_equal?(coord_letters_ascii)
    # returns true if the coordinate letters are all the same
    coord_letters_ascii.all? { |x| x == coord_letters_ascii[0] }
  end

  def numbers_consecutive?(coord_numbers)
    coord_numbers.each_cons(2).all? { |a, b| b == a + 1 }
  end

end
