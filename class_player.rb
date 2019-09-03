class Player
  attr_accessor :cards

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

    @cards = []
    @@all_players << self
  end

  def add_card(card)
    @cards << card
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
end
