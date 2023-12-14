# spec/item_spec.rb
require 'date'
require_relative '../classes/item'

RSpec.describe Item do
  let(:publish_date) { '2022-01-01' }
  let(:label) { double('label', items: []) }
  let(:author) { double('author', items: [], add_item: nil) }

  describe '#initialize' do
    it 'creates a new Item with valid attributes' do
      item = Item.new(publish_date)
      expect(item.id).to be_between(1, 1000)
      expect(item.publish_date).to eq(publish_date)
    end
  end

  describe '#label=' do
    let(:item) { Item.new(publish_date) }

    it 'sets the label for the item' do
      item.label = label
      expect(label.items).to include(item)
    end
  end

  describe '#move_to_archive' do
    let(:item) { Item.new(publish_date) }

    context 'when the item can be archived' do
      it 'archives the item' do
        allow(item).to receive(:can_be_archived?).and_return(true)
        item.move_to_archive
        expect(item.archived).to be true
      end
    end
  end
end
