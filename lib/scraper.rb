require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_info = []
    doc.css("div.roster-cards-container").collect do |info|
      info.css(".student-card a").collect do |card|
        profile_url = card.values.flatten.first
        name = card.css(".student-name").text
        location = card.css(".student-location").text
        student_info << {:name => name, :location => location, :profile_url => profile_url}
      end
    end
    student_info
    #binding.pry
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    doc = Nokogiri::HTML(open(profile_url))
    links = doc.css(".social-icon-container").children.css("a").map do |info|
      info.attribute("href").value
    end
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    end
    doc.css("div.main-wrapper.profile").collect do |info|
      student[:profile_quote] = info.css("div.profile-quote").text
      student[:bio] = info.css("div.description-holder p").text
    end
    student
  end

end
