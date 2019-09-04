require_relative 'class_game'
require_relative 'class_player'
require_relative 'menu_methods'
require 'tty-prompt'
require 'json'

FILE_PATH = 'save-data.json'

def argv_init(argv)
  player_hash = {
    'scarlet' => Player.character_list[0],
    'mustard' => Player.character_list[1],
    'plum' => Player.character_list[2],
    'green' => Player.character_list[3],
    'peacock' => Player.character_list[4],
    'white' => Player.character_list[5]
  }
  number_of_cpu_players = 5
  player_selection = player_hash['scarlet']

  if !argv.empty?
    if argv.include?('-p')
      index = argv.index('-p')
      arg_players = argv[index + 1].to_i
      if arg_players > 0 && arg_players <= 6
        number_of_cpu_players = arg_players - 1
      else
        puts "Warning: Invalid player number. Default value used."
      end
    end

    if argv.include?('-c')
      index = argv.index('-c')
      arg_character = argv[index + 1]
      if player_hash.include?(arg_character)
        player_selection = player_hash[arg_character]
      else
        puts 'Warning: Invalid character selection. Default character used.'
      end
    end
  end

  return {
    number_of_cpu_players: number_of_cpu_players,
    player_selection: player_selection
  }
end

def new_game(arg_hash, user_object)
  game = Game.new

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
  exit
end

def show_player_info(user_object)
  user_object.display_self
  Player.display_players
  user_object.display_cards
end

def save_game(game_object)
  game = {
    envelope_cards: game_object.envelope_cards,
    checklist: game_object.checklist
  }
  players = []
  Player.all_players.each do |player|
    players << {
      is_user: player.is_user,
      character: player.character,
      cards_in_hand: player.cards_in_hand
    }
  end

  data = {
    game: game,
    players: players
  }

  File.open(FILE_PATH, 'w') do |file|
    file.write(JSON.generate(data))
  end

  puts "Game saved to #{FILE_PATH}"
end

def load_game(game_object, user_object)
  # begin
    json = JSON.parse(File.read(FILE_PATH))
    game_object.envelope_cards = json['game']['envelope_cards']
    game_object.checklist = json['game']['checklist']
    game_object.format_table
    cpu_players = []
    json['players'].each do |player|
      if player['is_user']
        user_object.character = player['character']
        user_object.cards_in_hand = player['cards_in_hand']
      else
        load_player = Player.new
        load_player.character = player['character']
        load_player.cards_in_hand = player['cards_in_hand']
        cpu_players << load_player
      end
    end
    Player.load_cpu_players(cpu_players)
    puts "Successfully loaded game."
  # rescue => e
  #   puts 'Error: failed to load game.'
  # end
end