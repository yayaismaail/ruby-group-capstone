require_relative 'app'
require_relative 'book_refactor'

def main
  puts 'Welcome to the Catalog of my things App!'
  puts ' '
  app = App.new
  book_refactor = Refactor.new(app)
  app.load_data

  loop do
    display_options
    input_number = gets.chomp.to_i

    if input_number == 10
      puts "\e[31mThank you for using this app! ♥️ \e[0m"
      break
    end
    if input_number < 4
      handle_menu_choice(input_number, app, book_refactor)
    elsif input_number > 3
      actions(input_number, app)
    end
  end
end

def handle_menu_choice(input_number, app, book_refactor)
  case input_number
  when 1
    book_refactor.add_book
  when 2
    app.list_all_books
  when 3
    app.list_all_labels
  else
    puts 'Invalid option. Please try again.'
  end
end

def actions(input_number, app)
  case input_number
  when 4
    app.add_game
  when 5
    app.list_games
  when 6
    app.list_authors
  when 7
    app.add_music_album
  when 8
    app.list_all_albums
  when 9
    app.list_all_genres
  else
    puts 'Invalid option. Please try again.'
  end
end

def display_options
  puts "\e[35mPlease Enter or Input Any Option [1-10]\e[0m"
  puts "\e[33m1. - 📚 Add book\e[0m"
  puts "\e[33m2. - 📖 List all books\e[0m"
  puts "\e[33m3. - 🏷 List all labels\e[0m"
  puts "\e[32m4. - 🎮 Add a game\e[0m"
  puts "\e[32m5. - 🎲 List all games\e[0m"
  puts "\e[32m6. - 👤 List all authors\e[0m"
  puts "\e[34m7. - 🎵 Add a music album\e[0m"
  puts "\e[34m8. - 📀 List all music albums\e[0m"
  puts "\e[34m9. - 🎶 List all genres\e[0m"
  puts "\e[31m10. - 🚪 Exit\e[0m"
end

main
