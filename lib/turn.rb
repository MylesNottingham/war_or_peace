class Turn
  attr_reader :player1, :player2, :spoils_of_war, :won
  
  def initialize(player1, player2)
      @player1 = player1
      @player2 = player2
      @player1_first_card = @player1.deck.rank_of_card_at(0)
      @player2_first_card = @player2.deck.rank_of_card_at(0)
      @player1_third_card = @player1.deck.rank_of_card_at(2)
      @player2_third_card = @player2.deck.rank_of_card_at(2)
      @spoils_of_war = []
      @type = self.type
      @won = self.winner
  end

  def type
    if @player1_first_card == @player2_first_card && @player1_third_card == @player2_third_card
      @type = :mutually_assured_destruction
    elsif @player1_first_card == @player2_first_card
      @type = :war
    else
      @type = :basic
    end
    @type
  end

  def winner
    if @type == :mutually_assured_destruction
      @won = Player.new("No Winner", [])
    elsif @type == :war
      @player1_third_card > @player2_third_card ? @won = player1 : @won = player2
    else
      @player1_first_card > @player2_first_card ? @won = player1 : @won = player2
    end
    @won
  end

  def pile_cards
    if @type == :mutually_assured_destruction
      3.times {@player1.deck.remove_card}
      3.times {@player2.deck.remove_card}
    elsif @type == :war
      3.times {spoils_of_war << @player1.deck.remove_card}
      3.times {spoils_of_war << @player2.deck.remove_card}
    else
      spoils_of_war << @player1.deck.remove_card
      spoils_of_war << @player2.deck.remove_card
    end
  end

  def award_spoils
    @spoils_of_war.each do |card|
      @won.deck.add_card(card)
    end
  end
end