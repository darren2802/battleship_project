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
    @computer_hits = Hash.new
    @computer_seek_new_enemy_ship = true
    @number_enemy_ships_found = 0
    @counter = 0
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
    shot_result = ''
    coord = ''
    hash_key = "enemy_ship_#{@number_enemy_ships_found}"
    if @computer_seek_new_enemy_ship
      random_cell = ''
      loop do
        random_cell = @user_board.cells.keys.sample
        break if !@user_board.cells[random_cell].fired_upon?
      end
      @user_board.cells[random_cell].fire_upon
      shot_result = @user_board.cells[random_cell].render(true)
      coord = random_cell
      random_cell
    else
      reference_coord = @computer_hits[hash_key][:coords].last
      target_cell = adjacent_target_cell(reference_coord)
      @user_board.cells[target_cell].fire_upon
      shot_result = @user_board.cells[target_cell].render(true)
      coord = target_cell
    end

    hash_key = ''
    if shot_result == 'H'
      # do this if this the first hit on the user ship
      if @computer_seek_new_enemy_ship
        @number_enemy_ships_found += 1
        hash_key = "enemy_ship_#{@number_enemy_ships_found}"
        @computer_hits[hash_key] = Hash.new
        @computer_hits[hash_key][:is_sunk] = false
        @computer_hits[hash_key][:coords] = [coord]
      # do this if this is a subsequent hit on the user ship
      else
        hash_key = "enemy_ship_#{@number_enemy_ships_found}"
        @computer_hits[hash_key][:coords] << coord
      end
      @computer_seek_new_enemy_ship = false
    elsif shot_result == 'X'
      @computer_seek_new_enemy_ship = true
      #@computer_hits[hash_key][:is_sunk] = true
    end

    coord
  end

  def adjacent_target_cell(reference_coord)
    reference_coord_letter = reference_coord.slice(0,1)
    reference_coord_letter_ascii = reference_coord_letter.ord
    reference_coord_number = reference_coord.slice(1,1).to_i
    adjacent_cells = []
    adjacent_cells << (reference_coord_letter_ascii - 1).chr + reference_coord_number.to_s
    adjacent_cells << reference_coord_letter + (reference_coord_number + 1).to_s
    adjacent_cells << (reference_coord_letter_ascii + 1).chr + reference_coord_number.to_s
    adjacent_cells << reference_coord_letter + (reference_coord_number - 1).to_s
    adjacent_cells_valid = adjacent_cells.find_all { |adjacent_cell| @user_board.valid_coordinate?(adjacent_cell) }
    random_cell = ''
    loop do
      random_cell = adjacent_cells_valid.sample
      @counter += 1
      break if !@user_board.cells[random_cell].fired_upon?
      if @counter > 5
        @computer_seek_new_enemy_ship = true
        break
      end
    end
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
