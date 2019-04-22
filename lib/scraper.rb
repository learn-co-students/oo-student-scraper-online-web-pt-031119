require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  attr_accessor :name, :location

  def initialize(student_collection)
    # binding.pry
    student_collection.each {|key, value| self.send(("#{key}="), value)}

  end

  def self.scrape_index_page(index_url)
    student_info = []
    learn_site = Nokogiri::HTML(open(index_url))
    section = learn_site.css("div.roster-cards-container")
    students = section.css("div.student-card")
    students.each do |student_data|
      student_hash = {}
      student_hash[:location] = student_data.css("div.card-text-container p.student-location").text

      student_hash[:name] = student_data.css("div.card-text-container h4.student-name").text
  
      student_hash[:profile_url] = student_data.css("a").attribute("href").value

      student_info << student_hash
      

    end

    student_info    

  end

  def self.scrape_profile_page(profile_url)
    profiles_info = {}
    profile_pages = Nokogiri::HTML(open(profile_url))
    quote_box = profile_pages.css("div.vitals-text-container")
    bio = profile_pages.css("div.bio-content")
    # binding.pry
    socials = profile_pages.css("div.social-icon-container")
    socials.css("a").each do |socialMedia|
      if socialMedia.attribute("href").value.match(/twitter/) ? true : false == true
        profiles_info[:twitter] = socialMedia.attribute("href").value
        
      elsif socialMedia.attribute("href").value.match(/github/) ? true : false == true
        profiles_info[:github] = socialMedia.attribute("href").value

      elsif socialMedia.attribute("href").value.match(/linkedin/) ? true : false == true
        profiles_info[:linkedin] = socialMedia.attribute("href").value

      else
        profiles_info[:blog] = socialMedia.attribute("href").value
        
      end
    end

    bio.each do |details|
      profiles_info[:bio] = details.css("div.description-holder").text.strip
    end

    profiles_info[:profile_quote] = quote_box.css("div.profile-quote").text
    profiles_info
  end

end

