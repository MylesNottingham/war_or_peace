require "rspec"
require "./lib/card"
require "./lib/deck"

RSpec.describe Deck do
  before(:each) do
    @card1 = Card.new(:diamond, 'Queen', 12)
    @card2 = Card.new(:spade, '3', 3)
    @card3 = Card.new(:heart, 'Ace', 14)
    @card4 = Card.new(:club, '5', 5)
  
    @deck = Deck.new([@card1, @card2, @card3])
  end

  it "exists" do
    expect(@deck).to be_an_instance_of(Deck)
  end

  it "can hold cards" do
    expect(@deck.cards).to match_array([@card1, @card2, @card3])
  end

  it "can return rank at index" do
    expect(@deck.rank_of_card_at(0)).to eq (12)
    expect(@deck.rank_of_card_at(2)).to eq (14)
  end

  it "can select high ranking cards" do
    expect(@deck.high_ranking_cards).to match_array([@card1, @card3])
  end

  it "can return percentage of high ranking cards" do
    expect(@deck.percent_high_ranking).to eq (66.67)
  end

  it "can remove cards" do
    @deck.remove_card

    expect(@deck.cards).to match_array([@card2, @card3])
    expect(@deck.high_ranking_cards).to match_array([@card3])
    expect(@deck.percent_high_ranking).to eq (50)
  end

  it "can add cards" do
    @deck.remove_card

    @deck.add_card(@card4)

    expect(@deck.cards).to match_array([@card2, @card3, @card4])
    expect(@deck.high_ranking_cards).to match_array([@card3])
    expect(@deck.percent_high_ranking).to eq (33.33)
  end
end
