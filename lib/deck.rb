require './lib/card'
require 'pry'

class Deck

  attr_reader :cards
  def initialize(cards)
    @cards = cards
  end

  def rank_of_card_at(card_number)
    cards[card_number].rank
  end

  def high_ranking_cards
      high_ranked_cards = []
      cards.each do |card|
        if card.rank > 10
          high_ranked_cards << card
        end
      end
    return high_ranked_cards
  end

  def percent_high_ranking
      percent = (high_ranking_cards.length.to_f/cards.length)*100
      return percent.round(2)
  end

  def remove_card
    cards.delete_at(0)
  end

  def add_card(card)
    cards.push(card)
  end

end
