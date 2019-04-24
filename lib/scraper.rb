require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = []

    doc.css("div.student-card").each do |student|
      students << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: "#{student.css("a").attr("href").value}"
      }
    end
    students
  end


  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    students_detail = {}

    doc.css("div.social-icon-container").children.css("a").each do |social_media|
      
      if social_media.attribute("href").value.include?("twitter")
        students_detail[:twitter] = social_media.attribute("href").value
      elsif social_media.attribute("href").value.include?("github")
        students_detail[:github] = social_media.attribute("href").value
      elsif social_media.attribute("href").value.include?("linkedin")
        students_detail[:linkedin] = social_media.attribute("href").value
      elsif social_media.attribute("href").value.include?(".com")
        students_detail[:blog] = social_media.attribute("href").value
      end
    end

    students_detail[:bio] = doc.css("div.description-holder p").text
    students_detail[:profile_quote] = doc.css("div.profile-quote").text

    students_detail
  end

end
