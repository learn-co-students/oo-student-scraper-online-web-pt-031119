require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  
  def self.scrape_index_page(index_url)
    website = Nokogiri::HTML(open(index_url))

      student_hash = {}
      students = []

      website.css("div.student-card").each do |student|
        student_hash = {
          :location => student.css("p.student-location").text,
          :name => student.css("h4.student-name").text,
          :profile_url => student.css("a").attribute("href").value,
        }
        students << student_hash
        #binding.pry
      end
      students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profiles = Nokogiri::HTML(html)

    student_hash  = {}
    links = profiles.css(".social-icon-container a").map {|anchor_tag| anchor_tag.attribute("href").value}
    
    links.each do |link|
      if link.include?("twitter")
        student_hash[:twitter] = link
      elsif link.include?("github")
        student_hash[:github] = link
      elsif link.include?("linkedin")
        student_hash[:linkedin] = link
      else 
        student_hash[:blog] = link
    end
  end
  
  student_hash[:profile_quote] = profiles.css(".profile-quote").text if profiles.css(".profile-quote")
  student_hash[:bio] = profiles.css(".description-holder p").text if profiles.css(".description-holder p")
  student_hash
  end

end

