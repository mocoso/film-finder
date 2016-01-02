require 'spec_helper'

describe Title do
  describe '#normalised' do
    it 'should downcase the title' do
      expect(Title.new('Superman').normalised).to eq('superman')
    end

    it 'should remove the year from the end of the title' do
      expect(Title.new('The Fast and the Furious (2001)').normalised).
        to eq('the fast and the furious')
    end

    it 'should remove punctuation from the title' do
      expect(Title.new('Star Wars: Return of the Jedi').normalised).
        to eq('star wars return of the jedi')

      expect(Title.new('The Fast And The Furious - Tokyo Drift').normalised).
        to eq('the fast and the furious tokyo drift')
    end

    it 'should replace roman numerals with numbers' do
      expect(Title.new('Back To The Future Part III').normalised).
        to eq('back to the future part 3')
    end

    it 'should replace & with and' do
      expect(Title.new('Fast & Furious').normalised).
        to eq('fast and furious')
    end
  end
end

