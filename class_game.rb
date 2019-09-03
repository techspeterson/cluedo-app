class Game
  # attr_accessor :decks
  # attr_accessor :envelope_cards
  attr_accessor :main_deck

  def initialize
    @decks = {
      suspect: ["Miss Scarlet", "Colonel Mustard", "Professor Plum", "Rev. Green", "Mrs. Peacock", "Mrs. White"],
      room: ["Study", "Kitchen", "Ballroom", "Conservatory", "Billiard Room", "Library", "Hall", "Lounge", "Dining Room"],
      weapon: ["Candlestick", "Dagger", "Lead Pipe", "Revolver", "Rope", "Spanner"]
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
end
