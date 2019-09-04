require_relative 'class_game'
require_relative 'class_player'
require_relative 'menu_methods'
require 'tty-prompt'

def new_game(number_of_cpu_players, player_user)
  game = Game.new

  game.choose_envelope_cards
  number_of_cpu_players.times do
    Player.new
  end

  game.combine_decks

  until game.main_deck.empty?
    Player.all_players.each do |player|
      player.add_card(game.draw_card) if !game.main_deck.empty?
    end
  end

  player_user.cards_in_hand.each do |card|
    player_user.update_checklist(card)
  end

  return game
end

def guess_all_categories
  suspect = suspect_menu
  room = room_menu
  weapon = weapon_menu
  return [suspect, room, weapon]
end

def make_guess(player_user)
  guesses = guess_all_categories

  Player.cpu_players.each do |player|
    found_cards = player.search_cards(guesses)
    if !found_cards.empty?
      card = found_cards.sample
      player_user.update_checklist(card)
      puts "#{player} has: #{card}"
    end
  end
end

def make_accusation(game_object)
  guesses = guess_all_categories
  envelope_cards = game_object.envelope_cards

  if guesses == envelope_cards
    puts 'You win!'
  else
    puts 'You lose...'
  end
  exit
end
