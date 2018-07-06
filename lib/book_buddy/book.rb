class BookBuddy::Book

  attr_accessor :title, :author, :price, :url, :details

  @@all = []

  def initialize(book_hash)
    @title = book_hash[:title]
    @author = book_hash[:author]
    @price = book_hash[:price]
    @url = book_hash[:url]
    @details = book_hash[:details]
    @@all << self
  end

  def self.create_from_collection(books_array)
    books_array.each do |hash|
      BookBuddy::Book.new(hash)
    end
  end

  def self.url
    @url
  end

  def add_book_details(details_hash)
    details_hash.each do |key, value|
      self.send(("#{key}="), value)
    end
  end

  def self.all
    @@all
  end

end
