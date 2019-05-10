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
    doc = Nokogiri::HTML(open(profile_url))
    doc.css("div.main-wrapper.profile").collect do |info|
      #info.css("div.social-icon-container a").each do |social|
        #if social.include?("twitter", "linkedin", "github")
      twitter = info.css("div.social-icon-container a").first.values
      linkedin = info.css("div.social-icon-container a")[1].values
      github = info.css("div.social-icon-container a")[2].values
      blog = info.info.css("div.social-icon-container a").first.values
      profile_quote = info.css("div.profile-quote").text
      bio = info.css("div.description-holder p").text
    end
  end

end
