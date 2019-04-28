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

    links = doc.css("div.social-icon-container").children.css("a").collect do |element|
      element.attribute('href').value
    end 
    links.each do |link|
      if link.include?("twitter")
        student_profile[:twitter] = link
      elsif link.include?("linkedin")
        student_profile[:linkedin] = link
      elsif link.include?("github")
        student_profile[:github] = link 
      else 
        student_profile[:blog] = link 
      end 
    end
    #binding.pry 
  # doc.css("div.vitals-text-container").each do |item|
  #   student_profile[:profile_quote] = item.css("div.profile-quote").text

    student_profile[:profile_quote] = doc.css("div.profile-quote").text
       
  # doc.css("div.details-container").each do |detail|
  #   student_profile[:bio] = detail.css("div.description-holder p").text.strip 

    student_profile[:bio] = doc.css("div.description-holder p").text.strip 
    student_profile 
  end
  
end

# .children.css("a")
#
# element.attribute('href').value
#  if link.include?("linkedin")
#         student[:linkedin] = link
#  else
#  student[:blog] = link



 

# scrape_profile_page

# doc.css("div.social-icon-container")
# doc.css("div.social-icon-container").children.css("a")                              collection of profiles to iterate over
# doc.css("div.social-icon-container").first.css("a").attribute("href").value         the twitter url of an individual student
# doc.css("div.vitals-text-container").first.css("div.profile-quote").text 




# scrape_index_page

# doc.css(".roster-cards-container")     
# doc.css("div.student-card")                                  collection of students to iterate over
# doc.css("div.student-card").first.css(".student-name").text     the name of an individual student 
# doc.css("div.student-card").first.css(".student-location").text     the location of an individual student 
# document.css("div.student-card").first.css("a").attribute("href").value     the profile url of an individual student 

