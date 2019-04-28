require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    flatiron = Nokogiri::HTML(open(index_url))

    flatiron.css("div.student-card").map do |profile|
      {
        name: profile.css("h4.student-name").text,
        location: profile.css("p.student-location").text,
        profile_url: profile.css("a").attr("href").value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))

    links = profile_page.css("div.social-icon-container a").map {|link| link["href"]}
    {
      twitter: links.find {|e| e.include?("twitter")},
      linkedin: links.find {|e| e.include?("linkedin")},
      github: links.find {|e| e.include?("github")},
      blog: links.find {|e| e.end_with?(".com/")},
      profile_quote: profile_page.css("div.profile-quote").text,
      bio: profile_page.css("div.description-holder p").text
    }.compact
  end
end
