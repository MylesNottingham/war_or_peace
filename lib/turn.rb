class Turn
  attr_reader :player1, :player2, :spoils_of_war, :won
  
  def initialize(player1, player2)
      @player1 = player1
      @player2 = player2
      @player1_card1 = @player1.deck.rank_of_card_at(0)
      @player2_card1 = @player2.deck.rank_of_card_at(0)
      @player1_card2 = @player1.deck.rank_of_card_at(1)
      @player2_card2 = @player2.deck.rank_of_card_at(1)
      @player1_card3 = @player1.deck.rank_of_card_at(2)
      @player2_card3 = @player2.deck.rank_of_card_at(2)
      @spoils_of_war = []
      @type = self.type
      @won = self.winner
      @no_winner = Player.new("No Winner", Deck.new([]))
  end

  def type
    if (
        @player1_card1 == @player2_card1 &&
        @player1_card3 == @player2_card3 &&
        @player1_card1 != 0 &&
        @player1_card3 != 0
        )
      @type = :mutually_assured_destruction
    elsif (
        @player1_card1 == @player2_card1 &&
        @player1_card1 != 0
        )
      @type = :war
    else
      @type = :basic
    end
    @type
  end

  def winner
    if @type == :basic
      if @player1_card1 > @player2_card1 
        @won = player1
      elsif @player1_card1 < @player2_card1
        @won = player2
      else
        @won = @no_winner
      end
    elsif @type == :war
      if @player1_card3 > @player2_card3
        @won = player1
      elsif @player1_card3 < @player2_card3
        @won = player2
      elsif @player1_card2 > @player2_card2
        @won = player1
      elsif @player1_card2 < @player2_card2
        @won = player2
      else
        @won = @no_winner
      end
    else
      @won = @no_winner
    end
    @won
  end

  def pile_cards
    if @type == :basic
      spoils_of_war << @player1.deck.remove_card
      spoils_of_war << @player2.deck.remove_card
    elsif @type == :war
      3.times {spoils_of_war << @player1.deck.remove_card if @player1.deck.cards.count >0}
      3.times {spoils_of_war << @player2.deck.remove_card if @player2.deck.cards.count >0}
    else
      3.times {@player1.deck.remove_card}
      3.times {@player2.deck.remove_card}
    end
  end

  def award_spoils
    @spoils_of_war.each do |card|
      @won.deck.add_card(card)
    end
  end
end