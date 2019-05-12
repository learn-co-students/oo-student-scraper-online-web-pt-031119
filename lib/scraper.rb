require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    scrapedlist = []
    # html = File.read('fixtures/student-site/index.html')
    doc = Nokogiri::HTML(open(index_url))
    # 'fixtures/student-site/index.html'
    # doc = Nokogiri::HTML(html)
    doc.css("div.student-card").each do |item|
      # binding.pry
      scrapedlist << {
      :name => item.css("h4.student-name").text,
      :location => item.css("p.student-location").text,
      :profile_url => item.css("a")[0]['href']
      # item.css("a").attribute("href").value
      }
    end

    # => [
          #   {:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "students/abby-smith.html"},
          #   {:name => "Joe Jones", :location => "Paris, France", :profile_url => "students/joe-jonas.html"},
          #   {:name => "Carlos Rodriguez", :location => "New York, NY", :profile_url => "students/carlos-rodriguez.html"},
          #   {:name => "Lorenzo Oro", :location => "Los Angeles, CA", :profile_url => "students/lorenzo-oro.html"},
          #   {:name => "Marisa Royer", :location => "Tampa, FL", :profile_url => "students/marisa-royer.html"}
          # ]
    scrapedlist

  end



  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    # binding.pry
    profile = {}

  if doc.xpath("//div[@class='social-icon-container']//img[@src='../assets/img/twitter-icon.png']/../@href").text != ""
      profile[:twitter] = doc.xpath("//div[@class='social-icon-container']//img[@src='../assets/img/twitter-icon.png']/../@href").text
    end
    if doc.xpath("//div[@class='social-icon-container']//img[@src='../assets/img/github-icon.png']/../@href").text != ""
        profile[:github] = doc.xpath("//div[@class='social-icon-container']//img[@src='../assets/img/github-icon.png']/../@href").text
      end
      if doc.xpath("//div[@class='social-icon-container']//img[@src='../assets/img/linkedin-icon.png']/../@href").text != ""
          profile[:linkedin] = doc.xpath("//div[@class='social-icon-container']//img[@src='../assets/img/linkedin-icon.png']/../@href").text
        end
        if doc.xpath("//div[@class='social-icon-container']//img[@src='../assets/img/rss-icon.png']/../@href").text != ""
            profile[:blog] = doc.xpath("//div[@class='social-icon-container']//img[@src='../assets/img/rss-icon.png']/../@href").text
          end

          profile[:profile_quote] = doc.css(".profile-quote").text if doc.css(".profile-quote")
          profile[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text if doc.css("div.bio-content.content-holder div.description-holder p")

    profile
  end

end

      # :linkedin => doc.css(),doc.xpath("//div[@class='social-icon-container']//img[@src='../assets/img/twitter-icfon.png']/../@href").text == ""
      # :github => doc.xpath("//div[@class='social-icon-container']//img[@src='../assets/img/twitter-icon.png']/../@href").text,
      # :blog => doc.css(),
      # :profile_quote => doc.css(),
      # :bio => doc.css()

      # if doc.xpath("//div[@class='social-icon-container']//img[@src='../assets/img/faceee-icon.png']/../@href").text == ""





    # => {:twitter=>"http://twitter.com/flatironschool",
        #   :linkedin=>"https://www.linkedin.com/in/flatironschool",
        #   :github=>"https://github.com/learn-co,
        #   :blog=>"http://flatironschool.com",
        #   :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
        #   :bio=> "I'm a school"
        #  }
