require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    student_info = []
    learn_site = Nokogiri::HTML(open(index_url))
    section = learn_site.css("div.roster-cards-container")
    students = section.css("div.student-card")
    student_hash = {}
    
    students.map do |student_data|
      student_hash[:location] = student_data.css("div.card-text-container p.student-location").text
      student_hash[:name] = student_data.css("div.card-text-container h4.student-name").text
      student_hash[:profile_url] = student_data.css("a").attribute("href").value
      student_info << student_hash
      # binding.pry

    end

    student_info
    

    # :name = student_data.css("div.card-text-container h4.student-name").text
    # :location = student_data.css("div.card-text-container p.student-location").text
    # :twitter = 
    # :linkedin = 
    # :github =
    # :blog =
    # :profile_quote =
    # :bio = 
    # :profile_url = student_data.css("a").attribute("href").value
    
    # binding.pry

  end

  def self.scrape_profile_page(profile_url)
    
  end

end

