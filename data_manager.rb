require 'json'

class DataManager
  def self.save_game(games)
    File.write('./data/games.json', JSON.dump(games))
  end

  def self.save_author(authors)
    File.write('./data/authors.json', JSON.dump(authors))
  end

  def self.save_genre(genres)
    File.write('./data/genres.json', JSON.dump(genres.map(&:to_json)))
  end

  def self.save_album(albums)
    File.write('./data/albums.json', JSON.dump(albums.map(&:to_json)))
  end

  def self.load_genres
    if File.exist?('./data/genres.json')
      JSON.parse(File.read('./data/genres.json')).map do |genre|
        Genre.new(
          genre['name'],
          genre['published_date']
        )
      end
    else
      File.write('./data/genres.json', JSON.dump([]))
      []
    end
  end

  def self.load_albums
    if File.exist?('./data/albums.json')
      JSON.parse(File.read('./data/albums.json')).map do |album|
        MusicAlbum.new(
          album['published_date'],
          on_spotify: album['on_spotify']
        )
      end
    else
      File.write('./data/albums.json', JSON.dump([]))
      []
    end
  end

  def self.load_games
    if File.exist?('./data/games.json')
      JSON.parse(File.read('./data/games.json')).map do |game|
        Game.new(
          publish_date: game['publish_date'],
          multiplayer: game['multiplayer'],
          last_played_at: game['last_played_at']
        )
      end
    else
      File.write('./data/games.json', JSON.dump([]))
      []
    end
  end

  def self.load_authors
    if File.exist?('./data/authors.json')
      JSON.parse(File.read('./data/authors.json')).map do |author|
        Author.new(first_name: author['first_name'], last_name: author['last_name'])
      end
    else
      File.write('./data/authors.json', JSON.dump([]))
      []
    end
  end
end
