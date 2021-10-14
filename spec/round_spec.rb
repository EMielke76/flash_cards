require './lib/card'
require './lib/turn'
require './lib/deck'
require './lib/round'

RSpec.describe Round do
  context 'Iteration II' do
    before :each do
      @card_1   = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
      @card_2   = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
      @card_3   = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "Noth north west", :STEM)
      @cards    = [@card_1, @card_2, @card_3]
      @deck     = Deck.new(@cards)
      @round    = Round.new(@deck)
      @new_turn = Turn.new("Juneau", @card_1)
    end

    it 'exists' do

      expect(@round.deck).to be_a(Deck)
      expect(@round.turns).to eq([])
      expect(@round.current_card).to eq(@card_1)
    end


    it 'can take a turn, and ready the next turn' do
      #require 'pry'; binding.pry
      expect(@new_turn).to be_a(Turn)

      @new_turn = @round.take_turn("Juneau")

      expect(@new_turn.correct?).to be(true)
      expect(@round.turns).to eq([@new_turn])
      expect(@round.number_correct).to eq(1)
      expect(@round.current_card).to eq(@card_2)
        #Taking a new turn
      @round.take_turn("Venus")

      expect(@round.turns.count).to eq(2)
      expect(@round.turns.last.feedback).to eq('Incorrect.')
      expect(@round.number_correct).to eq(1)
    end

    it 'can sort correct answers by category' do
      @round.take_turn("Juneau")
      @round.take_turn("Venus")

      expect(@round.number_correct_by_category(:Geography)).to eq(1)
      expect(@round.number_correct_by_category(:STEM)).to eq(0)
    end

    it 'can calculate % of total answer correct, and % by category' do
      @round.take_turn("Juneau")
      @round.take_turn("Venus")
      #require 'pry'; binding.pry
      expect(@round.percent_correct).to eq(50.0)
      expect(@round.percent_correct_by_category(:Geography)).to eq(100.0)
    end

    it 'can ready the next card' do
      @round.take_turn("Juneau")
      @round.take_turn("Venus")

      expect(@round.current_card).to eq(@card_3)
    end 
  end
end
