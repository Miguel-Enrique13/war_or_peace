require './lib/deck'
require './lib/card'
require 'pry'

class Player

  attr_reader :name, :player_deck
  def initialize (name, player_deck)
    @name = name
    @player_deck = player_deck
  end

  def has_lost?
      player_deck == []
  end


end
