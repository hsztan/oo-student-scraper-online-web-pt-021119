require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    hash = {}
    html = open('index_url')
    doc = Nokogiri::HTML(html).css(".roster-class-containers")

    name = doc.css(".student-name").text
    location = doc.css(".student-location").text
    profile = doc.ss("")
    binding.pry

  end

  def self.scrape_profile_page(profile_url)

  end

end
