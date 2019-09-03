class Game
  attr_accessor :main_deck

  @@suspect_list = ["Miss Scarlet", "Colonel Mustard", "Professor Plum", "Rev. Green", "Mrs. Peacock", "Mrs. White"]
  @@room_list = ["Study", "Kitchen", "Ballroom", "Conservatory", "Billiard Room", "Library", "Hall", "Lounge", "Dining Room"]
  @@weapon_list = ["Candlestick", "Dagger", "Lead Pipe", "Revolver", "Rope", "Spanner"]

  def initialize
    @decks = {
      suspect: Array.new(@@suspect_list),
      room: Array.new(@@room_list),
      weapon: Array.new(@@weapon_list)
    }
    @main_deck = []
    @envelope_cards = {
      suspect: nil,
      room: nil,
      weapon: nil
    }
  end

  def draw_card(deck=@main_deck)
    card = deck.sample
    deck.delete(card)
    return card
  end

  def choose_envelope_cards
    @decks.each_pair do |deck, card_list|
      card = draw_card(card_list)
      @envelope_cards[deck] = card
    end
  end

  def combine_decks
    @decks.each_value do |card_list|
      @main_deck.concat(card_list)
    end
    @main_deck.shuffle!
  end

  def envelope_cards
    return @envelope_cards.values
  end

  def self.suspect_list
    return @@suspect_list
  end

  def self.room_list
    return @@room_list
  end

  def self.weapon_list
    return @@weapon_list
  end
end
