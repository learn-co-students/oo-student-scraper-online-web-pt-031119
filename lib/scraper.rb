require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_index = []
    doc.css(".student-card").collect do |student|
      student_name = student.css("h4.student-name").text
      url = student.css("a")[0]["href"]
      student_location = student.css(".student-location").text
      student_index << {:name => student_name, :location => student_location, :profile_url => url}
    end
    student_index
  end

  def self.scrape_profile_page(profile_url)

  end

end
