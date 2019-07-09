require 'open-uri'
require 'pry'
require_relative "../config.rb"

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = index_page.css("div.student-card")

    students.collect do |student|
      {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a").attribute("href").value
      }
    end

  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    social_media = profile_page.css("div.social-icon-container a").collect {|e| e.attribute("href").value}

    {
      twitter: social_media.find {|e| e.include?("twitter")},
      linkedin: social_media.find {|e| e.include?("linkedin")},
      github: social_media.find {|e| e.include?("github")},
      blog: social_media.find {|e| e.end_with?(".com/")},
      profile_quote: profile_page.css("div.profile-quote").text,
      bio: profile_page.css("div.description-holder p").text
    }.compact

  end

end

#Scraper.scrape_index_page("./fixtures/student-site/index.html")
#Scraper.scrape_profile_page("./fixtures/student-site/students/ryan-johnson.html")
