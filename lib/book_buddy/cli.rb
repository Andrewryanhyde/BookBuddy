class BookBuddy::CLI

   BASE_PATH = "https://www.waterstones.com"

  def call
    puts "Welcome to BookBuddy!"
    make_books
    add_details_to_books
    list_books
    start
    goodbye
  end

  def make_books
    books_array = BookBuddy::Scraper.scrape_index_page('https://www.waterstones.com/books/bestsellers')
    BookBuddy::Book.create_from_collection(books_array)
  end

  def add_details_to_books
    BookBuddy::Book.all.each do |book|
      details = BookBuddy::Scraper.scrape_details_page(BASE_PATH + book.url)
      book.add_book_details(details)
    end
  end

  def list_books
    @books = BookBuddy::Book.all
    @books.each.with_index(1) do |book, i|
      puts "#{i}: #{book.title} - #{book.author} - #{book.price}"
    end
  end


  def start
    input = nil
    while input != "exit"
      puts "Type the number of the book you'd like to learn more about. To view the list again type 'list' and to exit, simply type 'exit'"
      input = gets.strip.downcase

      if input.to_i > 0
        selected = @books[input.to_i-1]
        puts "#{selected.title} - #{selected.author} - #{selected.price} - #{selected.details}"
      elsif input == "list"
        list_books
      else
        puts "I'm sorry, I'm not sure what you meant. Try typing either 'list' or 'exit'"
      end
    end
  end

    def goodbye
      puts "Be sure to check back tomorrow for more bestsellers!"
    end
end
