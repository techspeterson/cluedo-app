# frozen_string_literal: true

require_relative 'class_game'
require_relative 'menu_methods'
require_relative 'init_methods'

# App starts here
if ARGV.empty?
  process_main_menu
else
  arg_hash = process_argv(ARGV)
  game_object = create_game(arg_hash)
  game_object.user.show_player_info
  game_loop(game_object)
end
