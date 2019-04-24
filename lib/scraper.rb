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
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_profile = []
    #binding.pry
    doc.css(".vitals-container").collect do |student|
      student.css(".social-icon-container").collect do |media|
        binding.pry
        media.css("a").each_with_index do |url, index|
          for index <= media.css("a").count
            if media.css("a")[index]["href"].include? "twitter"
              twitter_url = media.css("a")[index]["href"]
            elsif media.css("a")[index]["href"].include? "linkedin"
              linkedin_url = media.css("a")[index]["href"]
            elsif media.css("a")[index]["href"].include? "github"
              github_url = media.css("a")[index]["href"]
            elsif media.css("a")[index]["href"].end_with?(".com/")
              blog_url = media.css("a")[index]["href"]
            end
          end
        end
      end
      # if media.css("a")[0]["href"].include? "twitter"
      #   twitter_url = media.css("a")[0]["href"]
      # elsif media.css("a")[0]["href"].include? ""

    end
  end

end
