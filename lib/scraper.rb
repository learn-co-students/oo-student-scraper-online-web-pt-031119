require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    student_card = doc.css(".student-card")

    student_card.each do |card|
      student_hash = {}
      student_hash[:name] = card.css("h4").text.strip
      student_hash[:location] = card.css("p").text.strip
      student_hash[:profile_url] = card.css("a")[0].attributes["href"].value
      students << student_hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_doc = doc.css(".main-wrapper")
    student = student_doc[0]
    profile_hash = {}

    student.css("a").each do |hash|
      hash.each do |k, v|
        if k == "href" && v.include?("twitter")
          profile_hash[:twitter] = v
        elsif k == "href" && v.include?("linkedin")
          profile_hash[:linkedin] = v
        elsif k == "href" && v.include?("github")
          profile_hash[:github] = v
        elsif k == "href" && v.include?("http")
          profile_hash[:blog] = v
        end
      end
    end

    student.css("div").each do |hash|
      hash.each do |k, v|
        if v == "profile-quote"
          profile_hash[:profile_quote] = hash.text
        end
      end
    end

    student.css("div").each do |hash|
      hash.each do |k, v|
        if v.include?("bio-content")
          profile_hash[:bio] = hash.css("p").text.strip
        end
      end
    end
    profile_hash
  end

end
