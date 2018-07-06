require 'open-uri'
require 'nokogiri'
require 'pry'

class BookBuddy::Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    books = []

    doc.css("div.info-wrap").each do |book|
      scraped_book = {}
      scraped_book[:title] = book.css('div.title-wrap a').text
      scraped_book[:author] = book.css('.author a').text
      scraped_book[:price] = book.css('.price').text
      scraped_book[:url] = book.css('a').attribute('href').value
      books << scraped_book
    end

    books
  end

  def book_link


  end


  def self.scrape_details_page(url)
    details_hash = {}

    book_page = "https://www.waterstones.com" + url
    doc = Nokogiri::HTML(open(url))

    details_hash[:details] = doc.css("div#scope_book_description p").text

    details_hash
  end

end
