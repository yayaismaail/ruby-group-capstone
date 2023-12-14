# genre class
require 'securerandom'
require_relative 'item'

class MusicAlbum < Item
  attr_accessor :on_spotify, :published_date
  attr_reader :archived

  def initialize(published_date, on_spotify: false)
    super(published_date)
    @published_date = published_date
    @on_spotify = on_spotify
  end

  def to_json(_option = {})
    {
      published_date: @published_date,
      on_spotify: @on_spotify
    }
  end

  def can_be_archived?
    super && @on_spotify
  end
end
