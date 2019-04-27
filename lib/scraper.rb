require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    flatiron = Nokogiri::HTML(html)

    profiles = []
binding.pry
    flatiron.css("div.student-card").each do |profile|
      profiles << {
        name: profile.css("h4.student-name").text,
        location: profile.css("p.student-location").text,
        profile_url: profile.css("div.student-card a").attribute("href").value
      }
      binding.pry
    end
    profiles
    binding.pry
    #return an array of hashes, each hash rep a single student
    #hash keys name, location, profile_url
  end

  def self.scrape_profile_page(profile_url)

  end

end
