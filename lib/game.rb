
require_relative './cell'
require_relative './board'

require 'pry'

class Game
<<<<<<< HEAD
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
=======
  attr_reader :computer_ships,
              :user_ships,
              :computer_board,
              :user_board

  def initialize(computer_ships, user_ships, computer_board, user_board)
    @computer_ships = computer_ships
    @user_ships = user_ships
    @computer_board = computer_board
    @user_board = user_board
  end


  def generate_coordinates(computer_ship)
    ship_length = computer_ship.length
    placement_direction = random_ship_direction
    possible_coordinates = possible_first_coordinates(ship_length, placement_direction)

    loop do
      first_coordinate = possible_coordinates.sample
      first_coordinate_letter = first_coordinate.slice(0, 1)
      first_coordinate_letter_ascii = first_coordinate_letter.ord
      first_coordinate_number = first_coordinate.slice(1, 1).to_i
      coordinates = [first_coordinate]

      if placement_direction == 'vertical'
        (ship_length - 1).times do
          first_coordinate_letter_ascii += 1
          letter = first_coordinate_letter_ascii.chr
          coordinates << letter + first_coordinate_number.to_s
        end
      else
        (ship_length - 1).times do
          first_coordinate_number += 1
          coordinates << first_coordinate_letter + first_coordinate_number.to_s
        end
      end
      return coordinates if @computer_board.valid_placement?(computer_ship, coordinates)
    end
  end


  def place_ships(board, ships, coordinates, randomize_coordinates = true)
    ships.each do |ship|
      if randomize_coordinates
        coordinates = generate_coordinates(ship)
      else
        coordinates = coordinates
      end
      board.place(ship, coordinates)
    end
  end


  def possible_first_coordinates(ship_length, placement_direction)
    right_bound = @computer_board.width
    bottom_bound = @computer_board.height
    right_limit = 0
    bottom_limit = 0

    # determine bounds
    if placement_direction == 'horizontal'
      bottom_limit = bottom_bound
      right_limit = right_bound - ship_length + 1
    elsif placement_direction == 'vertical'
      right_limit = right_bound
      bottom_limit = bottom_bound - ship_length + 1
    end

    # generate coordinates based on limits
    coordinates = []
    bottom_limit.times do |x|
      right_limit.times do |y|
        coordinate_letter = (65 + x).chr
        coordinate_number = (1 + y).to_s
        coordinates << coordinate_letter + coordinate_number
      end
    end
    coordinates
  end


  def random_ship_direction
    rand_num = rand
    direction = ''
    if rand_num > 0.5
      direction = 'horizontal'
    else
      direction = 'vertical'
    end
    direction
  end

  def computer_fires_shot
    random_cell = ''
    loop do
      random_cell = @user_board.cells.keys.sample
      break if !@user_board.cells[random_cell].fired_upon?
    end
    @user_board.cells[random_cell].fire_upon
    random_cell
>>>>>>> 4e103c4f0ac6f677c5e9c29a7b1b6a494356bf3e
  end
end

end
