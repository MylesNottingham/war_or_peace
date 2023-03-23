require "rspec"
require "./lib/card"
require "./lib/deck"
require "./lib/player"
require "./lib/turn"

RSpec.describe Deck do
  describe "Can play :basic" do
    before :each do
      @card1 = Card.new(:heart, 'Jack', 11)
      @card2 = Card.new(:heart, '10', 10)
      @card3 = Card.new(:heart, '9', 9)
      @card4 = Card.new(:diamond, 'Jack', 11)
      @card5 = Card.new(:heart, '8', 8)
      @card6 = Card.new(:diamond, 'Queen', 12)
      @card7 = Card.new(:heart, '3', 3)
      @card8 = Card.new(:diamond, '2', 2)

      @deck1 = Deck.new([@card1, @card2, @card5, @card8])
      @deck2 = Deck.new([@card3, @card4, @card6, @card7])

      @player1 = Player.new("Megan", @deck1)
      @player2 = Player.new("Aurora", @deck2)

      @turn = Turn.new(@player1, @player2)
    end

    it "exists" do
      expect(@turn).to be_an_instance_of(Turn)
    end

    it "has two players" do
      expect(@turn.player1.name).to eq ("Megan")
      expect(@turn.player2.name).to eq ("Aurora")
    end

    it "begins with no spoils" do
      expect(@turn.spoils_of_war).to eq ([])
    end

    it "has a turn type" do
      expect(@turn.type).to eq (:basic)
    end

    it "has a winner" do
      expect(@turn.winner.name).to eq ("Megan")
    end

    it "has spoils" do
      @turn.pile_cards

      expect(@turn.spoils_of_war).to match_array([@card1, @card3])
    end

    it "can play out turn type :basic" do
      @turn.pile_cards
      @turn.award_spoils

      expect(@turn.player1.deck.cards).to match_array([@card2, @card5, @card8, @card1, @card3])
      expect(@turn.player2.deck.cards).to match_array([@card4, @card6, @card7])
    end
  end

  describe "Can play :war" do
    it "can play out turn type :war" do
      card1 = Card.new(:heart, 'Jack', 11)
      card2 = Card.new(:heart, '10', 10)
      card3 = Card.new(:heart, '9', 9)
      card4 = Card.new(:diamond, 'Jack', 11)
      card5 = Card.new(:heart, '8', 8)
      card6 = Card.new(:diamond, 'Queen', 12)
      card7 = Card.new(:heart, '3', 3)
      card8 = Card.new(:diamond, '2', 2)

      deck1 = Deck.new([card1, card2, card5, card8])
      deck2 = Deck.new([card4, card3, card6, card7])

      player1 = Player.new("Megan", deck1)
      player2 = Player.new("Aurora", deck2)

      turn = Turn.new(player1, player2)

      expect(turn.type).to eq (:war)
      expect(turn.winner.name).to eq ("Aurora")

      turn.pile_cards

      expect(turn.spoils_of_war).to match_array([card1, card2, card5, card4, card3, card6])

      turn.award_spoils

      expect(turn.player1.deck.cards).to match_array([card8])
      expect(turn.player2.deck.cards).to match_array([card7, card1, card2, card5, card4, card3, card6])
    end
  end

  describe "Can play :mutually_assured_destruction" do
    it "can play out turn type :mutually_assured_destruction" do
      card1 = Card.new(:heart, 'Jack', 11)
      card2 = Card.new(:heart, '10', 10)
      card3 = Card.new(:heart, '9', 9)
      card4 = Card.new(:diamond, 'Jack', 11)
      card5 = Card.new(:heart, '8', 8)
      card6 = Card.new(:diamond, '8', 8)
      card7 = Card.new(:heart, '3', 3)
      card8 = Card.new(:diamond, '2', 2)

      deck1 = Deck.new([card1, card2, card5, card8])
      deck2 = Deck.new([card4, card3, card6, card7])

      player1 = Player.new("Megan", deck1)
      player2 = Player.new("Aurora", deck2)

      turn = Turn.new(player1, player2)

      expect(turn.type).to eq (:mutually_assured_destruction)
      expect(turn.winner.name).to eq ("No Winner")

      turn.pile_cards

      expect(turn.spoils_of_war).to match_array([])

      turn.award_spoils

      expect(turn.player1.deck.cards).to match_array([card8])
      expect(turn.player2.deck.cards).to match_array([card7])
    end
  end
end
