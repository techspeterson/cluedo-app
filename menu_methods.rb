require 'artii'

def main_menu
  a = Artii::Base.new :font => 'slant'
  # puts a.asciify('Cluedo')
  choices = [
    { name: 'New game', value: 'new' },
    { name: 'Load game', value: 'load' },
    { name: 'Exit', value: 'exit' }
  ]
  return Game.prompt.select(a.asciify('Cluedo'), choices)
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
  return Game.prompt.select('What would you like to do?', choices)
end

def suspect_menu
  choices = Game.suspect_list
  return Game.prompt.select('It was...', choices)
end

def room_menu
  choices = Game.room_list
  return Game.prompt.select('...in the...', choices)
end

def weapon_menu
  choices = Game.weapon_list
  return Game.prompt.select('...with the...!', choices)
end