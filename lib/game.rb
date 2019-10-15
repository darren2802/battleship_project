
require_relative './cell'
require_relative './board'

class Game
attr_reader :computer_ships,
            :user_ships,
            :computer_board,
            :user_board

def initialize
  @computer_ships = [ ]
  @user_ships = [ ]
  @user_ship1 = Ship.new("Cruiser", 3)
  @user_ship2 = Ship.new("Submarine", 2)
  @computer_board = Board.new
  @user_board = Board.new
end

def setup_computer_ships
  @computer_ship1 = Ship.new("Cruiser", 3)
  @computer_ship2 = Ship.new("Submarine", 2)
  @computer_ships << @computer_ship1
  @computer_ships << @computer_ship2
end

def generate_coordinates(computer_ship)
  possible_coordinates = ['A1','A2','A3','A4','B1','B2','B3','B4','C1','C2','C3','C4','D1','D2','D3','D4']

  loop do
    first_coordinate = possible_coordinates.sample
    first_coordinate_letter = first_coordinate.slice(0, 1).ord
    first_coordinate_number = first_coordinate.slice(1, 1)
    coordinates = [first_coordinate]
    (computer_ship.length - 1).times do
      first_coordinate_letter += 1
      letter = first_coordinate_letter.chr
      coordinates << letter + first_coordinate_number
    end
    return coordinates if @computer_board.valid_placement?(computer_ship, coordinates)
  end

end

def place_computer_ships
  @computer_ships.each do |ship|
    coordinates = generate_coordinates(ship)
    @computer_board.place(ship, coordinates)
  end
end

end
