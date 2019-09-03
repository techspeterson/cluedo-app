require_relative 'class_game'
require_relative 'class_player'
require_relative 'methods'

number_of_cpu_players = 5
player_user = Player.new(true)
game = new_game(number_of_cpu_players)

loop do
  player_user.display_cards
  p game.envelope_cards
  puts "1. make guess"
  puts "2. make accusation"
  menu = gets.chomp.to_i
  if menu == 1
    make_guess
  elsif menu == 2
    make_accusation(game)
  end
end