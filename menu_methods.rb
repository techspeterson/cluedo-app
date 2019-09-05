# frozen_string_literal: true

require 'artii'
require 'tty-prompt'
require_relative 'class_game'
require_relative 'class_player'
require_relative 'methods'
require_relative 'save_load_methods'
require_relative 'init_methods'

PROMPT = TTY::Prompt.new

def main_menu
  a = Artii::Base.new font: 'slant'
  choices = [
    { name: 'New game', value: 'new' },
    { name: 'Load game', value: 'load' },
    { name: 'Exit', value: 'exit' }
  ]
  PROMPT.select(a.asciify('Cluedo'), choices)
end

def game_menu
  choices = [
    { name: 'Make a guess', value: 'guess' },
    { name: 'Show checklist', value: 'checklist' },
    { name: 'Show player info', value: 'player' },
    { name: 'Make your accusation', value: 'accuse' },
    { name: 'Save game', value: 'save' },
    { name: 'Exit', value: 'exit' }
  ]
  PROMPT.select('What would you like to do?', choices)
end

def suspect_menu
  choices = Game.suspect_list
  PROMPT.select('It was...', choices)
end

def room_menu
  choices = Game.room_list
  PROMPT.select('...in the...', choices)
end

def weapon_menu
  choices = Game.weapon_list
  PROMPT.select('...with the...!', choices)
end

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

def process_main_menu
  menu = main_menu
  case menu
  when 'new'
    arg_hash = DEFAULT_ARGS
    choices = Player.character_list
    arg_hash[:player_selection] = PROMPT.select('Choose your player character:', choices)
    choices = [6, 5, 4, 3, 2]
    arg_hash[:number_of_cpu_players] = PROMPT.select('How many players? (Includes you and CPU players)', choices).to_i - 1
    game_object = init_from_args(arg_hash)
    game_object.user.show_player_info
    game_loop(game_object)
  when 'load'
    game_object = load_game
    game_loop(game_object)
  when 'exit'
    exit
  end
end
