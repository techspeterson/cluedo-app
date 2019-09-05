# frozen_string_literal: true

require 'json'
require_relative 'class_player'
require_relative 'methods'
require_relative 'menu_methods'

FILE_PATH = 'save-data.json'

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

def load_game
  begin
    json = JSON.parse(File.read(FILE_PATH))
    arg_hash = DEFAULT_ARGS
    game_object = create_game(arg_hash)
    game_object.envelope_cards = json['game']['envelope_cards']
    game_object.checklist = json['game']['checklist']
    game_object.format_table
    cpu_players = []
    json['players'].each do |player|
      if player['is_user']
        game_object.user.character = player['character']
        game_object.user.cards_in_hand = player['cards_in_hand']
      else
        load_player = Player.new
        load_player.character = player['character']
        load_player.cards_in_hand = player['cards_in_hand']
        cpu_players << load_player
      end
    end
    Player.load_cpu_players(cpu_players)
    puts 'Successfully loaded game.'
    game_object.user.show_player_info
    return game_object
  rescue StandardError => e
    puts "Error: failed to load game. Make sure #{FILE_PATH} is in the game directory."
    process_main_menu
  end
end
