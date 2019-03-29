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
    doc.css(".social-icon-container").css("a").each do |social|
      if social.values.first.include?("twitter")
        student[:twitter] = social.values.first
      elsif social.values.first.include?("linkedin")
        student[:linkedin] = social.values.first
      elsif social.values.first.include?("github")
        student[:github] = social.values.first
      else
        student[:blog] = social.values.first
      end
    end
      student[:profile_quote] = doc.css(".profile-quote").text
      student[:bio] = doc.css(".bio-content.content-holder").css(".description-holder p").text
      student
  end

end
