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