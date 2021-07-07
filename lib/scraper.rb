require 'open-uri'
require 'pry'

class Scraper
  #scrape_index_page is a Class method that scrapes the student index page
  #and returns an array of hashes where one hash represents one student's data.
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.student-card").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.css("a").attribute("href").value
      student_card = {name: name, location: location,
                     profile_url: profile_url}
      students.push(student_card)
    end
    return students
  end

  #scrape_profile_page is a Class method that scrapes a student's profile
  #page and returns a hash of student social media attributes.
  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    social_profiles = {}
    profile = doc.css(".social-icon-container a")
    profile.each do |link|
      linkText = link.attribute("href").value
      if linkText.include?("twitter")
        social_profiles[:twitter] = linkText
      elsif linkText.include?("linkedin")
        social_profiles[:linkedin] = linkText
      elsif linkText.include?("github")
        social_profiles[:github] = linkText
      elsif linkText.include?(".com")
        social_profiles[:blog] = linkText
      end
    end
    social_profiles[:profile_quote] = doc.css(".profile-quote").text
    social_profiles[:bio] = doc.css(".description-holder p").text
    return social_profiles
  end
end
