require 'rspec'
require './lib/card'
require './lib/deck'

RSpec.describe Deck do
  it "exists" do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)

    cards = [card1, card2, card3]

    deck = Deck.new(cards)

    expect(deck).to be_an_instance_of(Deck)
  end

  it "can hold cards" do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)

    cards = [card1, card2, card3]

    deck = Deck.new(cards)

    expect(deck.cards).to match_array([
      have_attributes(
        class: Card,
        suit: :diamond,
        value: 'Queen',
        rank: 12
      ),
      have_attributes(
        class: Card,
        suit: :spade,
        value: '3',
        rank: 3
      ),
      have_attributes(
        class: Card,
        suit: :heart,
        value: 'Ace',
        rank: 14
      ),
    ])
  end

  it "can return rank at index" do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)

    cards = [card1, card2, card3]

    deck = Deck.new(cards)

    expect(deck.rank_of_card_at(0)).to eq (12)
    expect(deck.rank_of_card_at(2)).to eq (14)
  end

  it "can select high ranking cards" do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)

    cards = [card1, card2, card3]

    deck = Deck.new(cards)

    expect(deck.high_ranking_cards).to match_array([
      have_attributes(
        class: Card,
        suit: :diamond,
        value: 'Queen',
        rank: 12
      ),
      have_attributes(
        class: Card,
        suit: :heart,
        value: 'Ace',
        rank: 14
      ),
    ])
  end

  it "can return percentage of high ranking cards" do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)

    cards = [card1, card2, card3]

    deck = Deck.new(cards)

    expect(deck.percent_high_ranking).to eq (66.67)
  end

  it "can remove cards" do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)

    cards = [card1, card2, card3]

    deck = Deck.new(cards)

    deck.remove_card

    expect(deck.cards).to match_array([
      have_attributes(
        class: Card,
        suit: :spade,
        value: '3',
        rank: 3
      ),
      have_attributes(
        class: Card,
        suit: :heart,
        value: 'Ace',
        rank: 14
      ),
    ])

    expect(deck.high_ranking_cards).to match_array([
      have_attributes(
        class: Card,
        suit: :heart,
        value: 'Ace',
        rank: 14
        )
    ])

    expect(deck.percent_high_ranking).to eq (50)
  end

  it "can add cards" do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)

    cards = [card1, card2, card3]

    deck = Deck.new(cards)

    deck.remove_card

    card4 = Card.new(:club, '5', 5)

    deck.add_card(card4)

    expect(deck.cards).to match_array([
      have_attributes(
        class: Card,
        suit: :spade,
        value: '3',
        rank: 3
      ),
      have_attributes(
        class: Card,
        suit: :heart,
        value: 'Ace',
        rank: 14
      ),
      have_attributes(
        class: Card,
        suit: :club,
        value: '5',
        rank: 5
      ),
    ])

    expect(deck.high_ranking_cards).to match_array([
      have_attributes(
        class: Card,
        suit: :heart,
        value: 'Ace',
        rank: 14
        )
    ])

    expect(deck.percent_high_ranking).to eq (33.33)
  end
end
