require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    flatiron = Nokogiri::HTML(open(index_url))
    profiles = []
    flatiron.css("div.student-card").each do |profile|
      profiles << {
        name: profile.css("h4.student-name").text,
        location: profile.css("p.student-location").text,
        profile_url: profile.css("a").attr("href").value
      }
    end
    profiles
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    binding.pry
    { twitter_url: profile_page.css("div.social-icon-container a").attr("href").value,
      #linkedin_url:
      #twitter_url:
      #linkedin_url:
      #github_url:
      #blog:url:
      #profile_quote:
      #bio:
    }

  end

end
