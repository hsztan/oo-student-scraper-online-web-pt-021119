require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []
    html = open(index_url)
    doc = Nokogiri::HTML(html).css(".roster-cards-container")
    doc.each do |sudent|
      puts student.css(".student-name")
      binding.pry
    end

    # name = doc.css(".student-name").text
    # location = doc.css(".student-location").text
    #
    # binding.pry
    scraped_students
  end

  def self.scrape_profile_page(profile_url)

  end

end
