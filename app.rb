require_relative 'class_game'
require_relative 'class_player'
require_relative 'methods'
require_relative 'menu_methods'

arg_hash = argv_init(ARGV)
user_object = Player.new(true, arg_hash[:player_selection])
game_object = new_game(arg_hash, user_object)
user_object.cards_in_hand.each do |card|
  game_object.update_checklist(card)
end

load_game(game_object, user_object)
show_player_info(user_object)

loop do
  menu = user_menu
  case menu
  when 'guess'
    make_guess(game_object)
  when 'accuse'
    make_accusation(game_object)
  when 'checklist'
    puts game_object.display_checklist
  when 'player'
    show_player_info(user_object)
  when 'save'
    save_game(game_object)
  when 'exit'
    exit
  end
end