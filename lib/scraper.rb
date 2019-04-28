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

    social = [:twitter, :linkedin, :github, :blog]
    links = profile_page.css("div.social-icon-container a").map {|link| link["href"]}

    social_hash = social.each_index.with_object({}) do |i, h|
      if links[i].include?(social[i].to_s)
        h[social[i]] = links[i]
        #binding.pry
      else
        h[social[3]] = links[-1]
        #binding.pry
      end
      #binding.pry
    end.delete_if {|k,v| v == nil}

    profile = {
      profile_quote: profile_page.css("div.profile-quote").text,
      bio: profile_page.css("div.description-holder p").text
    }
    final_hash = social_hash.merge(profile)

    final_hash
    #binding.pry
  end

end
