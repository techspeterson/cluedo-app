require_relative 'class_game'
require_relative 'class_player'
require_relative 'methods'
require_relative 'menu_methods'

arg_hash = argv_init(ARGV)
player_user = Player.new(true)
game = new_game(arg_hash[:number_of_cpu_players], player_user)

loop do
  player_user.display_cards

  menu = user_menu
  case menu
  when 1
    make_guess(player_user)
  when 2
    make_accusation(game)
  when 3
    puts player_user.display_checklist
  when 99
    exit
  end
end