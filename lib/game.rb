require_relative './cell'
require_relative './board'

require 'pry'

class Game
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
  end

  def all_sunk?
    result = nil
    user_ships_all =  @user_ships.all? { |ship| ship.sunk? }
    computer_ships_all =  @computer_ships.all? { |ship| ship.sunk? }

    if user_ships_all
      result = 'I win!'
    elsif computer_ships_all
      result = 'You win!'
    else
      false
    end
  end

  def render_boards(show_computer_ships = false)
    puts "=============COMPUTER BOARD============="
    puts computer_board.render(show_computer_ships)
    puts "==============PLAYER BOARD=============="
    puts user_board.render(true)
  end

end
