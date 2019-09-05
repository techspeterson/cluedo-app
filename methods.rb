# frozen_string_literal: true

require_relative 'class_game'
require_relative 'class_player'
require_relative 'menu_methods'

def guess_all_categories
  suspect = suspect_menu
  room = room_menu
  weapon = weapon_menu
  [suspect, room, weapon]
end

def state_guess(guesses_array)
  "It was #{guesses_array[0]} in the #{guesses_array[1]} with the #{guesses_array[2]}!"
end

def make_guess(game_object)
  guesses = guess_all_categories
  puts "\"#{state_guess(guesses)}\""
  puts ''

  match_found = false
  Player.cpu_players.each do |player|
    found_cards = player.search_cards(guesses)
    next if found_cards.empty?

    match_found = true
    card = found_cards.sample
    game_object.update_checklist(card)
    puts "#{player} has: #{card}"
  end

  puts 'No players have cards to show you.' unless match_found
  puts ''
end

def make_accusation(game_object)
  guesses = guess_all_categories
  envelope_cards = game_object.envelope_cards.values

  puts "\"#{state_guess(guesses)}\""
  begin
    confirm = PROMPT.yes?('Are you sure you want to make this accusation?')
  rescue StandardError => e
    confirm = false
  end
  return unless confirm

  puts ''
  puts 'The correct answer is...'
  puts state_guess(envelope_cards)

  if guesses == envelope_cards
    puts 'You win!'
  else
    puts 'You lose...'
  end
  choices = [
    { name: 'Return', value: 'menu' },
    { name: 'Exit', value: 'exit' }
  ]
  restart = PROMPT.select('Return to menu?', choices)
  if restart == 'menu'
    process_main_menu
  else
    exit
  end
end
