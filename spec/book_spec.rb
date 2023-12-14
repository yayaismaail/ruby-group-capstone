require 'rspec'
require_relative '../classes/book'

describe Book do
  before :each do
    @book = Book.new('2000-01-01', 'Publisher', 'good')
  end

  it 'initializes with correct attributes' do
    expect(@book.publisher).to eq('Publisher')
    expect(@book.cover_state).to eq('good')
  end

  it 'can be archived if older than 10 years' do
    expect(@book.can_be_archived?).to eq(true)
  end

  it 'can be archived if cover state is bad' do
    @book.cover_state = 'bad'
    expect(@book.can_be_archived?).to eq(true)
  end
end
