require_relative 'class_game'
require_relative 'class_player'
require_relative 'methods'

number_of_cpu_players = 5
player_user = player_character = Player.new(true)
game = start_game(number_of_cpu_players)

player_user.display_cards