require './lib/deck'
require './lib/card'
require './lib/player'
require './lib/turn'
require 'pry'

suits = [:hearts, :diamonds, :spades, :clubs]
ranks = (2..14).to_a
values = (2..10).to_a

#String values of all cards
values.each_with_index do |value, i|
  values[i] = value.to_s
end
values << ["Jack", "Queen", "King", "Ace"]
values.flatten!

#Build Fulll Deck of Cards
full_deck = []
suits.each do |suit|
  ranks.each_with_index do |rank, value|
    full_deck << Card.new(suit, rank, values[value])
  end
end

#User input player names
print "Input Player 1 name: "
player_name1 = gets.chomp

print "Input Player 2 name: "
player_name2= gets.chomp

puts "Welcome to War! (or Peace) This game will be played with 52 cards."
puts "The players today are #{player_name1} and #{player_name2}."
puts "Type 'GO' to start the game!"
puts "-"*105

#shuffle Deck a few times
full_deck = full_deck.shuffle
full_deck = full_deck.shuffle
full_deck = full_deck.shuffle

#split Deck into 2 equal part

deck1 = Deck.new(full_deck[0..25])
deck2 = Deck.new(full_deck[26..51])


#give each player a deck
@player1 = Player.new(player_name1, deck1)
@player2 = Player.new(player_name2, deck2)

start_game = gets.chomp.upcase

while start_game != "GO"
  puts "Please type 'GO' to start the game!"
  start_game = gets.chomp.upcase
end

def start
  i = 1
  while i <= 1000000
    turn = Turn.new(@player1, @player2)
     if turn.type == :basic
       turn_winner = turn.winner
       puts "Turn #{i}: #{turn_winner.name} won 2 cards"
       turn.pile_cards
       turn.award_spoils(turn_winner)

     elsif turn.type == :war
       turn_winner = turn.winner
       puts "Turn #{i}: WAR - #{turn_winner.name} won 6 cards"
       turn.pile_cards
       turn.award_spoils(turn_winner)

     else
       puts "Turn #{i}: *mutually assured destruction* 6 cards remove from play"
       turn.pile_cards
     end
#if player has lost i.e has no more cards break the while loop
     if turn.player1.player_deck.cards == [] || turn.player2.player_deck.cards == []
       break
     end

#If player has 2 cards and a WAR happens, player with 2 cards losses!
     if turn.player1.player_deck.cards[0].rank == turn.player2.player_deck.cards[0].rank && (turn.player1.player_deck.cards.length < 3 || turn.player2.player_deck.cards.length < 3 )
       if turn.player1.player_deck.cards.length <= 2
         turn.player2.player_deck.cards << turn.player1.player_deck.remove_card
         turn.player2.player_deck.cards << turn.player1.player_deck.remove_card
       else
         turn.player1.player_deck.cards << turn.player2.player_deck.remove_card
         turn.player1.player_deck.cards << turn.player2.player_deck.remove_card
       end
       break
     end
     i += 1
  end

  if turn.player1.player_deck.cards == []
    puts "*~*~*~*~* #{@player2.name} has won the game! *~*~*~*~*"
  elsif turn.player2.player_deck.cards == []
    puts "*~*~*~*~* #{@player1.name} has won the game! *~*~*~*~*"
  else
    print "-"*7
    print " DRAW "
    print "-"*7
  end

end

start
