# spec/author_spec.rb
require 'json'
require_relative '../classes/author'

RSpec.describe Author do
  let(:author_params) { { first_name: 'John', last_name: 'Doe' } }
  let(:item) { double('item') }

  describe '#initialize' do
    it 'creates a new Author with valid attributes' do
      author = Author.new(**author_params)
      expect(author.id).to be_between(1, 1000)
      expect(author.first_name).to eq('John')
      expect(author.last_name).to eq('Doe')
      expect(author.items).to eq([])
    end
  end

  describe '#to_json' do
    it 'returns a JSON representation of the author' do
      author = Author.new(**author_params)
      json_data = author.to_json
      parsed_json = JSON.parse(json_data)

      expect(parsed_json['id']).to eq(author.id)
      expect(parsed_json['first_name']).to eq(author.first_name)
      expect(parsed_json['last_name']).to eq(author.last_name)
    end
  end
end
