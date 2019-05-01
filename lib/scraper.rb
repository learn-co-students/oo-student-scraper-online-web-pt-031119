require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
      doc.css("div.roster-cards-container").each do |card|
      card.css("div.student-card a").each do |student|
         student_name = student.css('.student-name').text
         student_location = student.css('.student-location').text

         student_profile_url = student.attr('href')
         students << {name: student_name , location: student_location, profile_url: student_profile_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    students = {}
    doc = Nokogiri::HTML(open(profile_url))
    
      links = doc.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    
          
  end

end

# find CSS selector for parent of all pictures.
#iterate over each picture and extract the name, location, profile- url
# create a hash for every picture and push it to array.


