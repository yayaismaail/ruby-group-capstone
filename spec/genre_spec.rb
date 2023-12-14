require 'rspec'
require_relative '../classes/genre'
require_relative '../classes/item'

RSpec.describe Genre do
  describe '#general' do
    it 'creates a Genre object with provided name and published date' do
      name = 'Test Genre'
      published_date = '2023-01-15'

      genre = Genre.new(name, published_date)

      expect(genre.name).to eq(name)
      expect(genre.published_date).to eq(published_date)
      expect(genre.items).to be_empty
    end
  end
end
