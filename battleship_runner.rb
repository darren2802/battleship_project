require_relative './lib/cell'
require_relative './lib/board'
require_relative './lib/game'
require 'pry'

puts 'Welcome to BATTLESHIP'

loop do
  puts 'Enter p to play. Enter q to quit.'
  user_response = gets.chomp
  break if user_response == 'p'
  exit if user_response == 'q'
  puts "Invalid Response, Try Again"
end

new_game = Game.new

new_game.setup_computer_ships
new_game.place_computer_ships

puts "Game On!"
