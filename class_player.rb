require 'tty-table'
require 'colorize'

class Player
  attr_accessor :cards_in_hand
  attr_accessor :checklist
  attr_reader :table_rows
  attr_accessor :character
  attr_accessor :checklist
  attr_accessor :checklist_formatted
  attr_accessor :is_user

  @@character_list = ["Miss Scarlet".colorize(:red), "Colonel Mustard".colorize(:yellow), "Professor Plum".colorize(:magenta), "Rev. Green".colorize(:green), "Mrs. Peacock".colorize(:blue), "Mrs. White".colorize(:light_white)]
  @@all_players = []
  @@cpu_players = []

  def initialize(is_user=false, player_selection=nil)
    if is_user
      @character = player_selection
      @@character_list.delete(player_selection)
      @is_user = true
    else
      @character = @@character_list.sample
      @@character_list.delete(@character)
      @is_user = false
      @@cpu_players << self
    end

    @cards_in_hand = []
    @@all_players << self
  end

  def add_card(card)
    @cards_in_hand << card
  end

  def display_self
    puts "You are playing as #{@character}."
  end

  def display_cards
    puts "Your cards:"
    @cards_in_hand.each do |card|
      puts card
    end
    puts ''
  end

  def self.display_players
    puts "You are playing against #{@@cpu_players.join(', ')}"
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

  def self.character_list
    return @@character_list
  end

  def to_s
    return @character
  end

  def self.load_cpu_players(players)
    @@cpu_players = players
  end
end
