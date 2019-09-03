require_relative 'class_game'
require_relative 'class_player'

def start_game
  game = Game.new
  number_of_cpu_players = 5

  game.choose_envelope_cards
  player_character = Player.new(true)
  number_of_cpu_players.times do
    Player.new
  end

  game.combine_decks

  # Player.all_players.each do |player|
  #   player.add_card(game.draw_card)
  # end
end