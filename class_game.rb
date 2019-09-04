require 'tty-prompt'
require 'colorize'

class Game
  attr_accessor :main_deck
  attr_accessor :envelope_cards

  @@SUSPECT_LIST = ["Miss Scarlet", "Colonel Mustard", "Professor Plum", "Rev. Green", "Mrs. Peacock", "Mrs. White"].map do |suspect|
    suspect.colorize(:light_yellow)
  end
  @@ROOM_LIST = ["Study", "Kitchen", "Ballroom", "Conservatory", "Billiard Room", "Library", "Hall", "Lounge", "Dining Room"].map do |room|
    room.colorize(:light_blue)
  end
  @@WEAPON_LIST = ["Candlestick", "Dagger", "Lead Pipe", "Revolver", "Rope", "Spanner"].map do |weapon|
    weapon.colorize(:light_red)
  end

  def initialize
    @decks = {
      suspect: Array.new(@@SUSPECT_LIST),
      room: Array.new(@@ROOM_LIST),
      weapon: Array.new(@@WEAPON_LIST)
    }
    @main_deck = []
    @envelope_cards = {
      suspect: nil,
      room: nil,
      weapon: nil
    }
    @@prompt = prompt = TTY::Prompt.new
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

  def envelope_cards_values
    return @envelope_cards.values
  end

  def self.suspect_list
    return @@SUSPECT_LIST
  end

  def self.room_list
    return @@ROOM_LIST
  end

  def self.weapon_list
    return @@WEAPON_LIST
  end

  def self.prompt
    return @@prompt
  end
end
