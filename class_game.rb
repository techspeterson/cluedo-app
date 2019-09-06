# frozen_string_literal: true

require 'colorize'

class Game
  attr_accessor :main_deck
  attr_accessor :envelope_cards
  attr_accessor :checklist
  attr_reader :user

  @@suspect_list = ['Miss Scarlet', 'Colonel Mustard', 'Professor Plum', 'Rev. Green', 'Mrs. Peacock', 'Mrs. White'].map do |suspect|
    suspect.colorize(:light_yellow)
  end
  @@room_list = ['Study', 'Kitchen', 'Ballroom', 'Conservatory', 'Billiard Room', 'Library', 'Hall', 'Lounge', 'Dining Room'].map do |room|
    room.colorize(:light_blue)
  end
  @@weapon_list = ['Candlestick', 'Dagger', 'Lead Pipe', 'Revolver', 'Rope', 'Spanner'].map do |weapon|
    weapon.colorize(:light_red)
  end

  def initialize(user_object)
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
    init_checklist
    @user = user_object
  end

  def draw_card(deck = @main_deck)
    card = deck.sample
    deck.delete(card)
    card
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

  def checkbox(card)
    @checklist[card] ? '[x] ' : '[ ] '
  end

  def format_table
    @table_rows = []
    9.times do |index|
      suspect = room = weapon = ''
      if index < @@suspect_list.length
        suspect_name = @@suspect_list[index]
        suspect = checkbox(suspect_name) + suspect_name
      end
      if index < @@room_list.length
        room_name = @@room_list[index]
        room = checkbox(room_name) + room_name
      end
      if index < @@weapon_list.length
        weapon_name = @@weapon_list[index]
        weapon = checkbox(weapon_name) + weapon_name
      end
      @table_rows << [suspect, room, weapon]
    end

    @checklist_table = TTY::Table.new header: ['Suspects', 'Rooms', 'Weapons'], rows: @table_rows
  end

  def init_checklist
    checklist_hash = {}
    @@suspect_list.each do |suspect|
      checklist_hash[suspect] = false
    end
    @@room_list.each do |room|
      checklist_hash[room] = false
    end
    @@weapon_list.each do |weapon|
      checklist_hash[weapon] = false
    end
    @checklist = checklist_hash

    format_table
  end

  def display_checklist
    @checklist_table.render(:ascii)
  end

  def update_checklist(card)
    @checklist[card] = true
    format_table
  end

  def self.suspect_list
    @@suspect_list
  end

  def self.room_list
    @@room_list
  end

  def self.weapon_list
    @@weapon_list
  end

  def self.prompt
    @@prompt
  end
end
