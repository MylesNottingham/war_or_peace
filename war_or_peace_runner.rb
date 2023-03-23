require "./lib/card"
require "./lib/deck"
require "./lib/player"
require "./lib/turn"
require "./lib/start"
require "./lib/card_generator"
require "csv"

cards = CardGenerator.new("./lib/card_generator.csv").cards

shuffled_cards = cards.shuffle

deck1 = Deck.new(shuffled_cards[0..25])
deck2 = Deck.new(shuffled_cards[26..51])

player1 = Player.new("Megan", deck1)
player2 = Player.new("Aurora", deck2)

3.times {puts}

puts "Welcome to War! (or Peace) This game will be played with 52 cards.
The players today are Megan and Aurora.
Type 'GO' to start the game!
------------------------------------------------------------------"

start = gets.upcase.chomp
until start == "GO"
  puts "INVALID INPUT"
  start = gets.upcase.chomp
end

game = Start.new(player1, player2)