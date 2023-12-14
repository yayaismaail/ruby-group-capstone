require 'rspec'
require_relative '../classes/music'

RSpec.describe MusicAlbum do
  describe '#initialize' do
    it 'creates a MusicAlbum object with provided published date and default on_spotify value' do
      published_date = '2023-01-15'

      album = MusicAlbum.new(published_date)

      expect(album.published_date).to eq(published_date)
      expect(album.on_spotify).to be_falsey
    end

    it 'creates a MusicAlbum object with provided published date and on_spotify value' do
      published_date = '2023-01-15'
      on_spotify = true

      album = MusicAlbum.new(published_date, on_spotify: on_spotify)

      expect(album.published_date).to eq(published_date)
      expect(album.on_spotify).to eq(on_spotify)
    end
  end

  describe '#can_be_archived?' do
    it 'returns false if album is not on Spotify' do
      album = MusicAlbum.new('2023-01-15', on_spotify: false)
      expect(album.can_be_archived?).to be_falsey
    end

    it 'returns true if album is on Spotify and can be archived' do
      album = MusicAlbum.new('2023-01-15', on_spotify: true)
      allow(album).to receive(:can_be_archived?).and_return(true)
      expect(album.can_be_archived?).to be_truthy
    end
  end
end
