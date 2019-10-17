require_relative './lib/cell'
require_relative './lib/board'
require_relative './lib/game'
require 'pry'

loop do
  puts ''
  puts 'Welcome to BATTLESHIP'
  puts ''
  loop do
    print 'Enter p to play. Enter q to quit: '
    user_response = gets.chomp
    break if user_response == 'p'
    exit if user_response == 'q'
    print "Invalid Response. "
  end

  puts ""

  user_height = 0
  print 'Please enter the height of the board (any number from 4 to 10): '
  loop do
    user_height = gets.chomp.to_i
    break if user_height >= 4 && user_height <= 10
    print 'Invalid input, please try again: '
  end

  user_width = 0
  print 'Please enter the width of the board (any number from 4 to 10): '
  loop do
    user_width = gets.chomp.to_i
    break if user_width >= 4 && user_width <= 10
    print 'Invalid input, please try again: '
  end

  computer_ships = []
  computer_ship1 = Ship.new("Cruiser", 3)
  computer_ship2 = Ship.new("Submarine", 2)
  computer_ships << computer_ship1
  computer_ships << computer_ship2

  user_ships = []
  user_ship1 = Ship.new("Cruiser", 3)
  user_ship2 = Ship.new("Submarine", 2)
  user_ships << user_ship1
  user_ships << user_ship2

  computer_board = Board.new(user_height, user_width)
  user_board = Board.new(user_height, user_width)

  new_game = Game.new(computer_ships, user_ships, computer_board, user_board)
  new_game.place_ships(computer_board, computer_ships, [])

  computer_text = "I have laid out my ships on the grid.\n"
  computer_text += "You now need to lay out your two ships.\n"
  computer_text += "The Cruiser is three units long and the Submarine is two units long.\n"
  puts computer_text
  puts ""
  puts computer_board.render #I changed this to render a regular board since it
  puts ""                    #gave away where the computer put their ships

  print "Enter the squares for the Cruiser (3 spaces): "
  user_coordinates = ''

  # for testing
  # user_coordinates = ['A4', 'B4', 'C4']

    loop do
      user_input = gets.chomp.upcase
      puts ""
      user_coordinates = user_input.split(/[,\s]+/)
      break if user_board.valid_placement?(user_ship1, user_coordinates)
      print "Invalid coordinates, please try again: "
    end

  puts ""
  new_game.place_ships(user_board, [user_ship1], user_coordinates, false)
  puts user_board.render(true)

  puts ""

  print "Enter the squares for the Submarine (2 spaces): "
  user_coordinates = ''

  # user_coordinates = ['D1', 'D2']

    loop do
      user_input = gets.chomp.upcase
      puts ""
      user_coordinates = user_input.split(/[,\s]+/)
      break if user_board.valid_placement?(user_ship2, user_coordinates)
      print "Invalid coordinates, please try again: "
    end

  puts ""
  new_game.place_ships(user_board, [user_ship2], user_coordinates, false)
  puts user_board.render(true)
  puts ""

  # turns
  result = false
  loop do

    # render the boards
    new_game.render_boards
    puts ''

    # user takes their turn
    user_coordinates = ' '
    print "Enter the coordinate for your shot: "
    #checks if coordinate is valid
    loop do
      user_coordinates = gets.chomp.upcase
      puts ""
      valid_coordinate = user_board.valid_coordinate?(user_coordinates)
      break if valid_coordinate
      print "Invalid coordinate, please try again: "
    end
    #check if cell has been fired upon, reprompt user if so
    loop do
      fired_upon = computer_board.cells[user_coordinates].fired_upon?
      break if !fired_upon
      print 'Cell already fired upon, please choose another coordinate: ' if fired_upon
      user_coordinates = gets.chomp.upcase
    end


    # fire upon computer_board with coordinate provided by user
    computer_board.cells[user_coordinates].fire_upon

    # computer takes its turn
    computer_coordinates = new_game.computer_fires_shot

    # results

    render_hash = {'H' => 'hit', 'M' => 'miss', 'X' => 'hit'}

    user_result = computer_board.cells[user_coordinates].render
    computer_result = user_board.cells[computer_coordinates].render

    puts "Your shot on #{user_coordinates} was a #{render_hash[user_result]}."
    puts "My shot on #{computer_coordinates} was a #{render_hash[computer_result]}."
    puts ""

    #break if
    result = new_game.all_sunk?
    break if result

  end
  puts result
  puts ""
  puts 'Final Board:'
  puts ""
  new_game.render_boards(true)
end
