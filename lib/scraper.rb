require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative '../student'


class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri:: HTML(open (./fixtures/student-site/index.html))
    
    doc.css(".roster-cards-container")each do |post|
    student = Student.new 
    student.name = roster-cards-container.css("h4").text 
    student.location = roster-cards-container.css("p").text
    student.profile_url = roster-cards-container.css("h3").text
    end 
  end 
    

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri:: HTML(open (http://twitter.com/flatironschool))
    
    
  end

end

