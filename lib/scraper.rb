require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

@@all = []
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_info = {}
      doc.css("div.card-text-container").collect do |info|
        student_info[:name] = info.css("h4").text
        student_info[:location] = info.css("p").text
      end
      doc.css("div.student-card a").collect do |link|
        student_info[:profile_url] = link.values
      end
      student_info
      binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end
