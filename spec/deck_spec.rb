require './lib/card'
require './lib/deck'

RSpec.describe Deck do
  context 'Iteration II' do
    before :each do
      @card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
      @card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
      @card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "Noth north west", :STEM)
      @cards  = [@card_1, @card_2, @card_3]
      @deck = Deck.new(@cards)
    end

    it 'has cards' do

      expect(@deck.cards).to eq([@card_1, @card_2, @card_3])
      expect(@deck.count).to eq(3)
    end

    it 'can display cards by category' do

      expect(@deck.cards_in_category(:STEM)).to eq([@card_2, @card_3])
      expect(@deck.cards_in_category(:Geography)).to eq([@card_1])
      expect(@deck.cards_in_category("Pop Cultre")).to eq([])
    end
  end
end
