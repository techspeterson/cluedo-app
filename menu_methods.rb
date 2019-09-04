def user_menu
  choices = [
    { name: 'Make a guess', value: 1 },
    { name: 'Make your accusation', value: 2 },
    { name: 'Show checklist', value: 3 },
    { name: 'Exit', value: 99 }
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