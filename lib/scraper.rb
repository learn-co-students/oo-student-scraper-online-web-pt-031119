require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    
    roster = []
    
    index.css("div.roster-cards-container").each do |card|
      card.css("div.student-card").each do |student|
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        student_url = student.css("a").first.attributes["href"].value
        roster << {:location => student_location, :name => student_name, :profile_url => student_url}
        # binding.pry
      end
    end
    roster
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    
    student = {}
    
    links = profile.css("div.social-icon-container a").map {|e| e.attribute("href").value}
    
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link 
      elsif link.include?("twitter")
        student[:twitter] = link 
      else 
        student[:blog] = link
      end   
    end
    
    student[:profile_quote] = profile.css(".profile-quote").text if profile.css(".profile-quote")
    student[:bio] = profile.css("div.bio-content.content-holder div.description-holder p").text if profile.css("div.bio-content.content-holder div.description-holder p")

    student
  end
  
end

# self.scrape_index_page(index_url)

#student index.css("div.student-card")
