class Player
  attr_accessor :cards
  attr_accessor :checklist

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
    @checklist = init_checklist
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

  def init_checklist
    suspect_hash = {}
    Game.suspect_list.each do |suspect|
      suspect_hash[suspect] = false
    end
    room_hash = {}
    Game.room_list.each do |room|
      room_hash[room] = false
    end
    weapon_hash = {}
    Game.weapon_list.each do |weapon|
      weapon_hash[weapon] = false
    end

    return [suspect_hash, room_hash, weapon_hash]
  end
end
