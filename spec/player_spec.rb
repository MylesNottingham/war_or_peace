require "rspec"
require "./lib/card"
require "./lib/deck"
require "./lib/player"

RSpec.describe Deck do
  before :each do
    @card1 = Card.new(:diamond, 'Queen', 12)
    @card2 = Card.new(:spade, '3', 3)
    @card3 = Card.new(:heart, 'Ace', 14)

    @deck = Deck.new([@card1, @card2, @card3])

    @player = Player.new('Clarisa', @deck)
  end

  it "exists" do
    expect(@player).to be_an_instance_of(Player)
  end

  it "has a name" do
    expect(@player.name).to eq("Clarisa")
  end

  it "has a deck" do
    expect(@player.deck.cards).to match_array([@card1, @card2, @card3])
  end

  it "is not a loser as long as it has cards" do
    expect(@player.has_lost?).to eq(false)
  end

  it "can lose" do
    expect(@player.has_lost?).to eq(false)

    2.times {@player.deck.remove_card}

    expect(@player.has_lost?).to eq(false)

    @player.deck.remove_card

    expect(@player.has_lost?).to eq(true)
  end
end
