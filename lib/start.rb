class Start
  def initialize(player1, player2)
    count = 0
    until player1.has_lost? || player2.has_lost? || count == 1000000
      count += 1
      turn = Turn.new(player1, player2)

      turn.pile_cards
      turn.award_spoils

      if turn.type == :basic
        puts "Turn #{count}: #{turn.won.name} won 2 cards"
      elsif turn.type == :war
        puts "Turn #{count}: WAR - #{turn.won.name} won #{turn.spoils_of_war.count} cards"
      else
        puts "Turn #{count}: *#{turn.type}* 6 cards removed from play"
      end
    end

    if player1.has_lost?
      puts "*~*~*~* #{player2.name} has won the game! *~*~*~*"
    elsif player2.has_lost?
      puts "*~*~*~* #{player1.name} has won the game! *~*~*~*"
    else
      puts "---- DRAW ----"
    end
  end
end