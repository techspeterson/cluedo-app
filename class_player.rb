require 'tty-table'

class Player
  attr_reader :cards_in_hand
  attr_accessor :checklist
  attr_reader :table_rows

  @@character_list = ["Miss Scarlet", "Colonel Mustard", "Professor Plum", "Rev. Green", "Mrs. Peacock", "Mrs. White"]
  @@all_players = []
  @@cpu_players = []

  def initialize(is_user=false)
    if is_user
      @character = @@character_list[0]
      @@character_list.delete_at(0)
    else
      @character = @@character_list.sample
      @@character_list.delete(@character)
      @@cpu_players << self
    end

    @cards_in_hand = []
    @@all_players << self
    @checklist_formatted = init_checklist
  end

  def add_card(card)
    @cards_in_hand << card
  end

  def display_cards
    puts "Your cards:"
    @cards_in_hand.each do |card|
      puts card
    end
  end

  def search_cards(search_terms)
    found_cards = []
    search_terms.each do |search_term|
      @cards_in_hand.each do |card|
        if card == search_term
          found_cards << card
        end
      end
    end
    return found_cards
  end

  def self.cpu_players
    return @@cpu_players
  end

  def self.all_players
    return @@all_players
  end

  def to_s
    return @character
  end

  def checkbox(card)
    return @checklist[card] ? ' [x]' : ' [ ]'
  end

  def set_table_rows
    @table_rows = []
    9.times do |index|
      suspect = room = weapon = ''
      if index < Game.suspect_list.length
        suspect_name = Game.suspect_list[index]
        suspect = suspect_name + checkbox(suspect_name)
      end
      if index < Game.room_list.length
        room_name = Game.room_list[index]
        room = room_name + checkbox(room_name)
      end
      if index < Game.weapon_list.length
        weapon_name = Game.weapon_list[index]
        weapon = weapon_name + checkbox(weapon_name)
      end
      @table_rows << [suspect, room, weapon]
    end

    return TTY::Table.new header: ['Suspects', 'Rooms', 'Weapons'], rows: @table_rows
  end

  def init_checklist
    checklist_hash = {}
    Game.suspect_list.each do |suspect|
      checklist_hash[suspect] = false
    end
    Game.room_list.each do |room|
      checklist_hash[room] = false
    end
    Game.weapon_list.each do |weapon|
      checklist_hash[weapon] = false
    end
    @checklist = checklist_hash

    set_table_rows
  end

  def display_checklist
    @checklist_formatted.render(:ascii)
  end

  def update_checklist(card)
    @checklist[card] = true
    @checklist_formatted = set_table_rows
  end
end
