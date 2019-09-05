# frozen_string_literal: true

require_relative 'class_game'
require_relative 'class_player'
require_relative 'methods'
require_relative 'save_load_methods'

DEFAULT_ARGS = {
  number_of_cpu_players: 5,
  player_selection: Player.character_list[0]
}

def process_argv(argv)
  player_hash = {
    'scarlet' => Player.character_list[0],
    'mustard' => Player.character_list[1],
    'plum' => Player.character_list[2],
    'green' => Player.character_list[3],
    'peacock' => Player.character_list[4],
    'white' => Player.character_list[5]
  }

  args_hash = DEFAULT_ARGS

  unless argv.empty?
    if argv.include?('-l')
      game_object = load_game
      game_loop(game_object)
    end

    if argv.include?('-p')
      index = argv.index('-p')
      arg_players = argv[index + 1].to_i
      if arg_players >= 2 && arg_players <= 6
        args_hash[:number_of_cpu_players] = arg_players - 1
      else
        puts 'Warning: Invalid player number. Default value used.'
      end
    end

    if argv.include?('-c')
      index = argv.index('-c')
      arg_character = argv[index + 1]
      if player_hash.include?(arg_character)
        args_hash[:player_selection] = player_hash[arg_character]
      else
        puts 'Warning: Invalid character selection. Default character used.'
      end
    end
  end

  args_hash
end

def init_from_args(arg_hash)
  user_object = Player.new(true, arg_hash[:player_selection])
  game_object = Game.new(user_object)

  game_object.choose_envelope_cards
  arg_hash[:number_of_cpu_players].times do
    Player.new
  end

  game_object.combine_decks

  until game_object.main_deck.empty?
    Player.all_players.each do |player|
      player.add_card(game_object.draw_card) unless game_object.main_deck.empty?
    end
  end
  game_object.user.cards_in_hand.each do |card|
    game_object.update_checklist(card)
  end
  game_object
end
