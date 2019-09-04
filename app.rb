require_relative 'class_game'
require_relative 'class_player'
require_relative 'methods'
require_relative 'menu_methods'

def game_loop(game_object)
  loop do
    menu = game_menu
    case menu
    when 'guess'
      make_guess(game_object)
    when 'accuse'
      make_accusation(game_object)
    when 'checklist'
      puts game_object.display_checklist
    when 'player'
      game_object.user.show_player_info
    when 'save'
      save_game(game_object)
    when 'exit'
      exit
    end
  end
end

if ARGV.empty?
  arg_hash = {
    number_of_cpu_players: 5,
    player_selection: Player.character_list[0]
  }
  game_object = init_from_args(arg_hash)
  menu = main_menu
  case menu
  when 'new'
    game_object.user.show_player_info
    game_loop(game_object)
  when 'load'
    load_game(game_object)
    game_loop(game_object)
  when 'exit'
    exit
  end
else
  arg_hash = process_argv(ARGV)
  game_object = init_from_args(arg_hash)
  game_object.user.show_player_info
  game_loop(game_object)
end
