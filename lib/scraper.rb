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
    student_profile = {}
    doc.css(".vitals-container").collect do |student|
      student.css(".social-icon-container").collect do |media|
        media.css("a").each_with_index do |url, index|
          if media.css("a")[index]["href"].include? "twitter"
            twitter_url = media.css("a")[index]["href"]
            student_profile[:twitter] = twitter_url
          elsif media.css("a")[index]["href"].include? "linkedin"
            linkedin_url = media.css("a")[index]["href"]
            student_profile[:linkedin] = linkedin_url
          elsif media.css("a")[index]["href"].include? "github"
            github_url = media.css("a")[index]["href"]
            student_profile[:github] = github_url
          elsif media.css("a")[index]["href"].end_with?(".com/")
            blog_url = media.css("a")[index]["href"]
            student_profile[:blog] = blog_url
          end
        end
      end
      quote = student.css(".vitals-text-container").css(".profile-quote").text
      student_profile[:profile_quote] = quote
    end

    doc.css(".details-container").collect do |student|
      bio_quote = student.css(".description-holder").css("p").text
      student_profile[:bio] = bio_quote
    end
   student_profile

  end #end of scrape_profile_page method

end #end Scraper class
