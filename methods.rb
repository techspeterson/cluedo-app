require_relative 'class_game'
require_relative 'class_player'

def start_game(number_of_cpu_players)
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
end

def make_guess
  def enter_guess(category)
    loop do
      case category
      when 'suspect'
        puts 'It was... (enter suspect)'
      when 'room'
        puts '...in the... (enter room)'
      when 'weapon'
        puts '...with the...! (enter weapon)'
      end

      guess = gets.strip
      if Game.send("#{category}_list").include?(guess)
        return guess
      else
        puts 'Error: Invalid entry.'
      end
    end
  end

  suspect = enter_guess('suspect')
  room = enter_guess('room')
  weapon = enter_guess('weapon')
end