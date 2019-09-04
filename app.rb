require_relative 'class_game'
require_relative 'class_player'
require_relative 'methods'
require_relative 'menu_methods'

arg_hash = argv_init(ARGV)
user_object = Player.new(true, arg_hash[:player_selection])
game = new_game(arg_hash, user_object)

show_player_info(user_object)

loop do
  menu = user_menu
  case menu
  when 'guess'
    make_guess(user_object)
  when 'accuse'
    make_accusation(game)
  when 'checklist'
    puts user_object.display_checklist
  when 'player'
    show_player_info(user_object)
  when 'exit'
    exit
  end
end