require 'minitest/autorun'
require_relative '../lib/game.rb'

class GameTest < Minitest::Test

  def setup
    @computer_ships = []
    @computer_ship1 = Ship.new("Cruiser", 3)
    @computer_ship2 = Ship.new("Submarine", 2)
    @computer_ships << @computer_ship1
    @computer_ships << @computer_ship2

    @user_ships = []
    @user_ship1 = Ship.new("Cruiser", 3)
    @user_ship2 = Ship.new("Submarine", 2)
    @user_ships << @user_ship1
    @user_ships << @user_ship2

    @computer_board = Board.new
    @user_board = Board.new
    @new_game = Game.new(@computer_ships, @user_ships, @computer_board, @user_board)
  end

  def test_game_initialized
    assert_instance_of Game, @new_game
  end



end
