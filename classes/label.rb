require_relative 'item'

class Label < Item
  attr_accessor :title, :color, :items
  attr_reader :id

  def initialize(title, color)
    super(publish_date)
    @id = Random.rand(1..1000)
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    @items << item
    item.label = self
  end
end
