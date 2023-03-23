class CardGenerator
  def initialize(filename)
    @filename = filename
  end

  def cards
    cards_csv = CSV.parse(File.read(@filename), headers: true)
    cards = []
    52.times do |index|
      cards << Card.new(cards_csv[index]["suit"], cards_csv[index]["value"], cards_csv[index]["rank"])
    end
    cards
  end
end