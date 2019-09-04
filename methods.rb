require_relative 'class_game'
require_relative 'class_player'
require_relative 'menu_methods'
require 'tty-prompt'

def new_game(number_of_cpu_players)
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

  return game
end

# def enter_guess(category)
#   loop do
#     case category
#     when 'suspect'
#       puts 'It was... (enter suspect)'
#     when 'room'
#       puts '...in the... (enter room)'
#     when 'weapon'
#       puts '...with the...! (enter weapon)'
#     end

#     guess = gets.strip
#     if Game.send("#{category}_list").include?(guess)
#       return guess
#     else
#       puts 'Error: Invalid entry.'
#     end
#   end
# end

def guess_all_categories
  # suspect = enter_guess('suspect')
  # room = enter_guess('room')
  # weapon = enter_guess('weapon')
  suspect = suspect_menu
  room = room_menu
  weapon = weapon_menu
  return [suspect, room, weapon]
end

def make_guess
  guesses = guess_all_categories

  Player.cpu_players.each do |player|
    found_cards = player.search_cards(guesses)
    if !found_cards.empty?
      puts "#{player} has: #{found_cards.sample}"
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
