class Player
  @@cards = {
    suspect: ["Miss Scarlet", "Colonel Mustard", "Professor Plum", "Rev. Green", "Mrs. Peacock", "Mrs. White"],
    room: ["Study", "Kitchen", "Ballroom", "Conservatory", "Billiard Room", "Library", "Hall", "Lounge", "Dining Room"],
    weapon: ["Candlestick", "Dagger", "Lead Pipe", "Revolver", "Rope", "Spanner"]
  }

  @@character_list = Array.new(@@cards[:suspect])
  @@envelope_cards = {
    suspect: nil,
    room: nil,
    weapon: nil
  }

  @user = false

  def initialize(is_user)
    if is_user
      @character = @@character_list[0]
      @@character_list.delete_at(0)
    else
      @character = @@character_list.sample
      @@character_list.delete(@character)
    end
  end

  def self.draw_card(deck)
    card = deck.sample
    deck.delete(card)
    return card
  end

  def self.choose_envelope_cards
    @@cards.each_pair do |deck, card_list|
      card = draw_card(card_list)
      @@envelope_cards[deck] = card
    end
  end

  def self.envelope_cards
    return @@envelope_cards
  end

  # def self.cards
  #   return @@cards
  # end
end