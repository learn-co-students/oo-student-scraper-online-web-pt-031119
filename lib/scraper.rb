require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
     
    doc = Nokogiri::HTML(open(index_url))
    
    student_info = []
    #student_hash = {}

    doc.css("div.student-card").each do |card|
      student_name = card.css(".student-name").text 
      student_location = card.css(".student-location").text
      student_profile_url = card.css("a").attribute("href").value
      student_hash = {:name => student_name, :location => student_location, :profile_url => student_profile_url}
      student_info << student_hash
    end
    student_info
  end 
      # student_hash[:name]=student_name 
      # student_hash[:location]=student_location 
      # student_hash[:profile_url]=student_profile_url 
        
  def self.scrape_profile_page(profile_url)
    
    doc = Nokogiri::HTML(open(profile_url))
    #binding.pry 

    student_profile = {}

    #binding.pry 

    doc.css("div.social-icon-container").each do |profile|
       
      binding.pry 
    end 
    #student_profile 
  end
  
end

 

# scrape_profile_page

# doc.css("a").attribute("href").value                     collection of profiles to iterate over
# doc.css("div.view-profile-div").first.css(".view-profile-text").text



# scrape_index_page

# doc.css(".roster-cards-container")     
# doc.css("div.student-card")                                  collection of students to iterate over
# doc.css("div.student-card").first.css(".student-name").text     the name of an individual student 
# doc.css("div.student-card").first.css(".student-location").text     the location of an individual student 
# document.css("div.student-card").first.css("a").attribute("href").value     the profile url of an individual student 

