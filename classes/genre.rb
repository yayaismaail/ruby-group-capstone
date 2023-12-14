# genre class
require 'securerandom'
require_relative 'item'

class Genre < Item
  attr_accessor :name, :published_date, :items
  attr_reader :id

  def initialize(name, published_date)
    super(published_date)
    @id = generate_id
    @name = name
    @items = []
    @published_date = published_date
  end

  def add_item(item)
    return if @items.include?(item)

    @items << item
    item.genre = self
  end

  def to_json(_option = {})
    {
      id: @id,
      name: @name,
      published_date: @published_date
    }
  end

  private

  def generate_id
    SecureRandom.rand(1..1000)
  end
end
