require_relative 'class_game'
require_relative 'class_player'
require_relative 'init_methods'

def initialise_game_test
  puts "Testing that init_from_args correctly creates the game object."
  
  scarlet = Player.character_list[0]  # Miss Scarlet (including colour formatting)

  arg_hash = {
    number_of_cpu_players: 5,
    player_selection: scarlet
  }

  game_object = init_from_args(arg_hash)

  if game_object.user.character.nil?
    puts "Test failed: cannot find user object in game object"
    return false
  end
  p game_object.user.character
  puts "Player character should be #{scarlet}..."
  if game_object.user.character == scarlet
    puts "...and it is! Test passed"
    return true
  else
    puts "...and it isn't :( Test failed"
    return false
  end
end

def search_cards_test
  puts "Tests that the player search_cards method returns the correct array of cards."

  dummy_player = Player.new
  dummy_player.cards_in_hand = [Game.suspect_list[0], Game.room_list[0], Game.weapon_list[0]]

  found_cards = dummy_player.search_cards([Game.room_list[0]])

  p found_cards
  if !found_cards.is_a?(Array)
    puts "Test failed: card search did not return an array"
    return false
  end
  puts "Found card array should contain #{Game.room_list[0]}..."
  if found_cards == [Game.room_list[0]]
    puts "...and it does! Test passed"
    return true
  else
    puts "...and it doesn't :( Test failed"
    return false
  end
end

initialise_game_test
search_cards_test