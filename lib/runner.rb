class Runner
  def initialize
  end

  def start
    print_header

    loop do
      print 'Enter p to play. Enter q to quit: '
      user_response = gets.chomp
      if user_response == 'p'
        break
      elsif user_response == 'q'
        exit
      else
        print "Invalid Response. "
      end
    end
    board_setup
  end

  def board_setup
    puts ""
    user_height = get_user_dimension('height')
    user_width = get_user_dimension('width')

    user_board = Board.new(user_height, user_width)
    computer_board = Board.new(user_height, user_width)

    ship_game_setup(user_board, computer_board)
  end

  def ship_game_setup(user_board, computer_board)
    computer_ships = ship_yard
    user_ships = ship_yard

    new_game = Game.new(computer_ships, user_ships, computer_board, user_board)
    new_game.place_ships(computer_board, computer_ships, [])

    puts  "\nI have laid out my ships on the grid.\nYou now need to lay out your two ships.\nThe Cruiser is three units long and the Submarine is two units long.\n\n"
    puts computer_board.render
    puts ""

    print "Enter the squares for the Cruiser (3 spaces): "
    user_coordinates = get_ship_coordinates(user_board, user_ships[0])

    new_game.place_ships(user_board, [user_ships[0]], user_coordinates, false)
    puts user_board.render(true)

    puts ""

    print "Enter the squares for the Submarine (2 spaces): "
    user_coordinates = get_ship_coordinates(user_board, user_ships[1])

    puts ""
    new_game.place_ships(user_board, [user_ships[1]], user_coordinates, false)
    puts user_board.render(true)
    puts ""

    turns(new_game)
  end

  def turns(game)
    result = false
    loop do
      game.render_boards
      puts ''

      # user takes their turn
      print "Enter the coordinate for your shot: "
      user_coordinates = get_target_coordinate(game.user_board)

      #check if cell has been fired upon, reprompt user if so
      loop do
        if game.computer_board.cells[user_coordinates].fired_upon?
          print 'Cell already fired upon, please choose another coordinate: '
          break
        end
        user_coordinates = gets.chomp.upcase
      end

      # fire upon computer_board with coordinate provided by user
      game.computer_board.cells[user_coordinates].fire_upon

      # computer takes its turn
      computer_coordinates = game.computer_fires_shot

      # results
      render_hash = {'H' => 'hit', 'M' => 'miss', 'X' => 'hit'}

      user_result = game.computer_board.cells[user_coordinates].render
      computer_result = game.user_board.cells[computer_coordinates].render

      puts "Your shot on #{user_coordinates} was a #{render_hash[user_result]}."
      puts "My shot on #{computer_coordinates} was a #{render_hash[computer_result]}."
      puts ""

      result = game.all_sunk?
      break if result
    end

    end_game(game)
  end

  def end_game(game)
    puts result
    puts ""
    puts 'Final Board:'
    puts ""
    game.render_boards(true)

    start
  end

  def print_header
    puts ''
    puts 'Welcome to BATTLESHIP'
    puts ''
  end

  def get_user_dimension(aspect)
    print "Please enter the #{aspect} of the board (any number from 4 to 10): "
    dimension = 0
    loop do
      dimension = gets.chomp.to_i
      break if dimension >= 4 && dimension <= 10
      print 'Invalid input, please try again: '
    end
    dimension
  end

  def ship_yard
    ships = []
    ships << Ship.new("Cruiser", 3)
    ships << Ship.new("Submarine", 2)
    ships
  end

  def get_ship_coordinates(user_board, user_ship)
    user_coordinates = ''
    loop do
      user_input = gets.chomp.upcase
      puts ""
      user_coordinates = user_input.split(/[,\s]+/)
      break if user_board.valid_placement?(user_ship, user_coordinates)
      print "Invalid coordinates, please try again: \n"
    end
    user_coordinates
  end

  def get_target_coordinate(user_board)
    user_coordinates = ''
    loop do
      user_coordinates = gets.chomp.upcase
      puts ""
      valid_coordinate = user_board.valid_coordinate?(user_coordinates)
      break if valid_coordinate
      print "Invalid coordinate, please try again: "
    end
    user_coordinates
  end
end
