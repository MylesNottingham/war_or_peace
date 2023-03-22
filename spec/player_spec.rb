require "rspec"
require "./lib/card"
require "./lib/deck"
require "./lib/player"

RSpec.describe Deck do
  it "exists" do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)

    deck = Deck.new([card1, card2, card3])

    player = Player.new('Clarisa', deck)

    expect(player).to be_an_instance_of(Player)
  end

  it "has a name" do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)

    deck = Deck.new([card1, card2, card3])

    player = Player.new("Clarisa", deck)

    expect(player.name).to eq("Clarisa")
  end

  it "has a deck" do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)

    deck = Deck.new([card1, card2, card3])

    player = Player.new("Clarisa", deck)

    expect(player.deck.cards).to match_array([card1, card2, card3])
  end

  it "is not a loser as long as it has cards" do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)

    deck = Deck.new([card1, card2, card3])

    player = Player.new("Clarisa", deck)

    expect(player.has_lost?).to eq(false)
  end

  it "can lose" do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)

    deck = Deck.new([card1, card2, card3])

    player = Player.new("Clarisa", deck)

    expect(player.has_lost?).to eq(false)

    2.times {player.deck.remove_card}

    expect(player.has_lost?).to eq(false)

    player.deck.remove_card

    expect(player.has_lost?).to eq(true)
  end
end
