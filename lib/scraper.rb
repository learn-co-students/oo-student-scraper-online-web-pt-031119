require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".roster-cards-container").each do |card|
      binding.pry
      card.css(".student-card a").each do |student|
        learn save
        
         student_name = student.css('.student-name').text
       end 
     end
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

# find CSS selector for parent of all pictures.
#iterate over each picture and extract the name, location, profile- url
# create a hash for every picture and push it to array.


