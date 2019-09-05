require_relative 'class_game'
require_relative 'class_player'
require_relative 'menu_methods'

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

  if !argv.empty?
    if argv.include?('-p')
      index = argv.index('-p')
      arg_players = argv[index + 1].to_i
      if arg_players >= 2 && arg_players <= 6
        args_hash[:number_of_cpu_players] = arg_players - 1
      else
        puts "Warning: Invalid player number. Default value used."
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

  return args_hash
end

def new_game(arg_hash, user_object)
  game = Game.new(user_object)

  game.choose_envelope_cards
  arg_hash[:number_of_cpu_players].times do
    Player.new
  end

  game.combine_decks

  until game.main_deck.empty?
    Player.all_players.each do |player|
      player.add_card(game.draw_card) if !game.main_deck.empty?
    end
  end

  return game
end

def init_from_args(arg_hash)
  user_object = Player.new(true, arg_hash[:player_selection])
  game_object = new_game(arg_hash, user_object)
  game_object.user.cards_in_hand.each do |card|
    game_object.update_checklist(card)
  end
  return game_object
end

def guess_all_categories
  suspect = suspect_menu
  room = room_menu
  weapon = weapon_menu
  return [suspect, room, weapon]
end

def state_guess(guesses_array)
  return "It was #{guesses_array[0]} in the #{guesses_array[1]} with the #{guesses_array[2]}!"
end

def make_guess(game_object)
  guesses = guess_all_categories
  puts "\"#{state_guess(guesses)}\""
  puts ''

  match_found = false
  Player.cpu_players.each do |player|
    found_cards = player.search_cards(guesses)
    if !found_cards.empty?
      match_found = true
      card = found_cards.sample
      game_object.update_checklist(card)
      puts "#{player} has: #{card}"
    end
  end

  if !match_found
    puts 'No players have cards to show you.'
  end

  puts ''
end

def make_accusation(game_object)
  guesses = guess_all_categories
  envelope_cards = game_object.envelope_cards_values

  puts "\"#{state_guess(guesses)}\""
  puts ""
  puts 'The correct answer is...'
  puts state_guess(envelope_cards)

  if guesses == envelope_cards
    puts 'You win!'
  else
    puts 'You lose...'
  end
  return
end
