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
    
     hash[:name] = student_name
     hash[:location] = student_location
     hash[:profile_url] = student_url
     array << hash
  end
  array
  end

  def self.scrape_profile_page(profile_url)
    file = Nokogiri::HTML(open(profile_url))
    student = {}
    file.css("div.social-icon-container a").each do |network|
      if network.attribute("href").text.include?("twitter")
        student[:twitter] = network.attribute("href").text
      elsif network.attribute("href").text.include?("linkedin")
        student[:linkedin] = network.attribute("href").text
      elsif network.attribute("href").text.include?("github")
        student[:github] = network.attribute("href").text
      else
        student[:blog] = network.attribute("href").text
      end
    end
    student[:profile_quote] = file.css("div.profile-quote").text
    student[:bio] = file.css("div.bio-content.content-holder .description-holder p").text
    student
  end

end

