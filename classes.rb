class Player
  @@cards = {
    suspects: ["Miss Scarlet", "Colonel Mustard", "Professor Plum", "Rev. Green", "Mrs. Peacock", "Mrs. White"],
    rooms: ["Study", "Kitchen", "Ballroom", "Conservatory", "Billiard Room", "Library", "Hall", "Lounge", "Dining Room"],
    weapons: ["Candlestick", "Dagger", "Lead Pipe", "Revolver", "Rope", "Spanner"]
  }

  @@character_list = Array.new(@@cards[:suspects])
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
end