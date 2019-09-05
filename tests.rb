require_relative 'class_game'
require_relative 'class_player'
require_relative 'init_methods'

def initialise_game_test
  puts "Testing that init_from_args correctly creates the game object."

  arg_hash = {
    number_of_cpu_players: 5,
    player_selection: Player.character_list[0]
  }

  expected = Player.character_list[0]  # Miss Scarlet (including colour formatting)
  actual = init_from_args(arg_hash).user.character

  if actual.nil?
    puts "Test failed: cannot find user object in game object"
    return false
  end
  p actual
  puts "Player character should be #{expected}..."
  if actual == expected
    puts "...and it is! Test passed"
    return true
  else
    puts "...and it isn't :( Test failed"
    puts "Actually returns: #{actual}"
    return false
  end
end

def search_cards_test
  puts "Testing that the player search_cards method returns the correct array of cards."

  dummy_player = Player.new
  dummy_player.cards_in_hand = [Game.suspect_list[0], Game.room_list[0], Game.weapon_list[0]]

  expected = [Game.room_list[0]]
  actual = dummy_player.search_cards([Game.room_list[0]])

  if !actual.is_a?(Array)
    puts "Test failed: card search did not return an array"
    return false
  end
  puts "Found card array should contain #{expected}..."
  if actual == [Game.room_list[0]]
    puts "...and it does! Test passed"
    return true
  else
    puts "...and it doesn't :( Test failed"
    puts "Actually returns: #{actual}"
    return false
  end
end

initialise_game_test
search_cards_test