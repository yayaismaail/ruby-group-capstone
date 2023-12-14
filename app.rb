require 'fileutils'
require_relative 'classes/games'
require_relative 'classes/author'
require_relative 'data_manager'
require_relative 'classes/book'
require_relative 'classes/label'
require_relative 'classes/genre'
require_relative 'classes/music'
require 'json'

class App
  attr_reader :labels, :books, :games, :authors

  def initialize
    @games = DataManager.load_games
    @authors = DataManager.load_authors
    @labels = []
    @books = []
    @genres = DataManager.load_genres
    @albums = DataManager.load_albums
  end

  def add_label(title, color)
    label = Label.new(title, color)
    @labels << label
    save_labels
  end

  def list_all_labels
    if @labels.empty?
      puts 'No labels added'
      puts ' '
    else
      puts 'List of all labels:'
      @labels.each_with_index do |label, index|
        puts "#{index + 1}. Label: #{label.title}, Color: #{label.color}"
        puts ' '
      end
    end
  end

  def list_all_books
    if @books.empty?
      puts 'No books added'
      puts ' '
    else
      @books.each_with_index do |book, index|
        print "#{index + 1}-[Book], "
        print "ID: #{book.id}, "
        print "Publisher: #{book.publisher}, "
        print "Publish Date: #{book.publish_date}, "
        print "Cover State: #{book.cover_state}, "
        puts "Archived: #{book.can_be_archived?}"
        puts ' '
      end
    end
  end

  def add_book(publisher, cover_state, publish_date)
    book = Book.new(publish_date, publisher, cover_state)
    @books << book
    puts ' '
    puts 'The book is added successfully ✅'
    puts '--__--__--__--__--__--__--__--__--'
    puts ' '
    save_data
  end

  def save_data
    save_books
    save_labels
  end

  def load_data
    load_books
    load_labels
  end

  def load_books
    if File.exist?('data/book.json')
      data = JSON.parse(File.read('data/book.json'))
      @books = data.map { |book| Book.new(book['publish_date'], book['publisher'], book['cover_state']) }
    else
      []
    end
  end

  def save_books
    File.open('data/book.json', 'w') do |file|
      data = @books.map do |book|
        {
          'id' => book.id,
          'publish_date' => book.publish_date,
          'publisher' => book.publisher,
          'cover_state' => book.cover_state
        }
      end
      file.write(JSON.generate(data))
    end
  end

  def load_labels
    if File.exist?('data/label.json')
      data = JSON.parse(File.read('data/label.json'))
      @labels = data.map { |label| Label.new(label['title'], label['color']) }
    else
      []
    end
  end

  def save_labels
    File.open('data/label.json', 'w') do |file|
      data = @labels.map do |label|
        {
          'title' => label.title,
          'color' => label.color
        }
      end
      file.write(JSON.generate(data))
    end
  end

  def list_games
    if @games.empty?
      puts "\n\e[31mNo games available!\e[0m\n"
    else
      puts "\nList of Games\n\n"
      puts '-------------------------------------------------------------------------'
      puts "| Publish Date \t\t| Mode \t\t\t| Last Played At \t|"
      puts '-------------------------------------------------------------------------'

      @games.each do |game|
        puts "| #{game.publish_date} \t\t| " \
             "#{game.multiplayer ? 'Multiplayer' : 'Singleplayer'}\t\t| " \
             "#{game.last_played_at}\t\t|"
        puts '-------------------------------------------------------------------------'
      end
    end
  end

  def list_all_genres
    if @genres.empty?
      puts "\n\e[31mNo genres available!\e[0m\n"
    else
      puts "\nList of Genres\n\n"
      puts '-------------------------------------------------'
      puts "| Name \t\t| "
      puts '-------------------------------------------------'

      @genres.each do |genre|
        puts "| #{genre.name} \t\t| "
        puts '-------------------------------------------------'
      end
    end
  end

  def list_all_albums
    if @albums.empty?
      puts "\n\e[31mNo music albums available!\e[0m\n"
    else
      puts "\nList of Music Albums\n\n"
      puts '-------------------------------------------------------------------------'
      puts "| Publish Date \t\t| On Spotify \t|"
      puts '-------------------------------------------------------------------------'

      @albums.each do |album|
        puts "| #{album.publish_date} \t\t| #{album.on_spotify ? 'Yes' : 'No'} \t\t|"
        puts '-------------------------------------------------------------------------'
      end
    end
  end

  def add_music_album
    puts "\nAdd a music album:"
    date = get_date_input('Published date (dd/mm/yy)')
    spotify = get_yes_no_input('On Spotify? [Y/N]')

    genre = add_genre(date)
    album = MusicAlbum.new(date, on_spotify: spotify)
    genre.add_item(album)

    @albums << album

    DataManager.save_album(@albums)
    puts "\e[32mMusic Album added successfully!\e[0m"
  end

  def add_genre(date)
    name = get_input('Genre name: ')

    genre = Genre.new(name, date)
    @genres ||= []
    @genres << genre

    DataManager.save_genre(@genres)

    genre
  end

  def add_game
    puts "\nAdd a game:"
    publish_date = get_date_input('Published date (dd/mm/yy)')
    multiplayer = get_yes_no_input('Multiplayer [Y/N]')
    last_played_at = get_date_input('Last played at (dd/mm/yy)')
    author = add_author
    game = Game.new(publish_date: publish_date, multiplayer: multiplayer, last_played_at: last_played_at)
    author.add_item(game)
    @games << game
    DataManager.save_game(@games)
    DataManager.save_author(@authors)

    puts "\e[32mGame added successfully!\e[0m"
  end

  def list_authors
    if @authors.empty?
      puts "\n\e[31mNo authors available!\e[0m\n"
    else
      puts "\nList of Authors \n\n"
      puts '---------------------------------------------------------'
      puts "| ID \t\t| Name \t\t\t\t\t|"
      puts '---------------------------------------------------------'

      @authors.each do |author|
        puts "| #{author.id} \t\t| #{author.first_name} #{author.last_name}"
        puts '---------------------------------------------------------'
      end
    end
  end

  def add_author
    puts "\nAdd author details:"
    first_name = get_input('First name')
    last_name = get_input('Last name')

    author = Author.new(first_name: first_name, last_name: last_name)

    @authors ||= []

    @authors << author

    DataManager.save_author(@authors)

    puts "\e[32mAuthor added successfully!\e[0m"

    # Return the newly created author
    author
  end

  def get_input(prompt)
    print "#{prompt}: "
    gets.chomp
  end

  def get_date_input(prompt)
    print "#{prompt}: "
    Date.parse(gets.chomp)
  rescue ArgumentError
    puts "\e[31mInvalid date format! Please enter in dd/mm/yy format.\e[0m"
    retry
  end

  def get_yes_no_input(prompt)
    print "#{prompt}: "
    gets.chomp.downcase == 'y'
  end
end
