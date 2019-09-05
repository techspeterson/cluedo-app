require_relative 'class_game'
require_relative 'class_player'
require_relative 'methods'
require_relative 'menu_methods'
require_relative 'save_load_methods'

# App starts here
if ARGV.empty?
  process_main_menu
else
  arg_hash = process_argv(ARGV)
  game_object = init_from_args(arg_hash)
  game_object.user.show_player_info
  game_loop(game_object)
end
