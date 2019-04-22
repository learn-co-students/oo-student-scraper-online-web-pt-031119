require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    array = []
    doc.css("div.student-card").collect do |student|
    hash = {}
    student_name = student.css("div.card-text-container h4.student-name").text
    student_location = student.css("div.card-text-container p.student-location").text
    student_url = student.css("a").attribute("href").text
    binding.pry
     hash[:name] = student_name
     hash[:location] = student_location
     hash[:profile_url] = student_url
     array << hash
     
  end
  end

  def self.scrape_profile_page(profile_url)
    file = Nokogiri::HTML(open(profile_url))
  end

end

