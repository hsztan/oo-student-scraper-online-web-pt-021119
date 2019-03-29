require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []
    html = open(index_url)
    doc = Nokogiri::HTML(html).css(".roster-cards-container")
    doc.css(".student-card").each do |student|
      hash = {}
      hash[:name] = student.css(".student-name").text
      hash[:location] = student.css(".student-location").text
      hash[:profile_url] = student.css("a").first.values.first
      scraped_students << hash
    end
    scraped_students.sort_by{|student| student[:name]}
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    doc = Nokogiri::HTML(open(profile_url)).css(".main-wrapper")
    doc.css(".social-icon-container").each do |social|
      student[:twitter] = social.css("a")[0].values.first
      student[:linkedin] = social.css("a")[1].values.first
      student[:github] = social.css("a")[2].values.first
      student[:blog] = social.css("a")[3].values.first
    end
      student[:profile_quote] = doc.css(".profile-quote").text
      student[:bio] = doc.css(".bio-content.content-holder").css(".description-holder p").text
      student
  end

end
