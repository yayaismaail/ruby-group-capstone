# item class

require 'securerandom'
require 'date'

class Item
  attr_accessor :publish_date
  attr_reader :id, :author, :label, :genre, :archived

  def initialize(publish_date, archived: false)
    @id = Random.rand(1..1000)
    @publish_date = publish_date
    @archived = archived
  end

  def label=(label)
    @label = label
    label.items << self unless label.items.include?(self)
  end

  def author=(author)
    @author = author
    author.add_item(self) unless author.items.include?(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_item(self) unless genre.items.include?(self)
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  private

  def can_be_archived?
    return false unless @publish_date

    publish_date_object = Date.parse(@publish_date)
    (Date.today.year - publish_date_object.year) > 10
  end
end
