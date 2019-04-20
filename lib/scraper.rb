require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    student_info = []
    learn_site = Nokogiri::HTML(open(index_url))
    # binding.pry
    section = learn_site.css("div.roster-cards-container")
    #students = section.css("div.student-card")
    student_hash = {}
    
    section.each do |student_data|
      student_data.css("div.card-text-container p.student-location").each do |text|
        student_hash[:location] = text.text
      end

      student_data.css("div.card-text-container h4.student-name").each do |text|
        student_hash[:name] = text.text
      end
  
      student_hash[:profile_url] = student_data.css("a").attribute("href").value

      student_info << student_hash
      # binding.pry
      student_info

    end

    student_info

    # <div class="student-card" id="kevin-mccormack-card">
    #         <a href="students/kevin-mccormack.html">
    #           <div class="view-profile-div">
    #             <h3 class="view-profile-text">View Profile</h3>
    #           </div>
    #           <div class="card-text-container">
    #             <h4 class="student-name">Kevin McCormack</h4>
    #             <p class="student-location">New York, NY</p>
    #           </div>
    #         </a>
    #       </div>

    

    # :name = student_data.css("div.card-text-container h4.student-name").text
    # :location = student_data.css("div.card-text-container p.student-location").text
    # :twitter = 
    # :linkedin = 
    # :github =
    # :blog =
    # :profile_quote =
    # :bio = 
    # :profile_url = student_data.css("a").attribute("href").value
    
    # binding.pry

  end

  def self.scrape_profile_page(profile_url)
    
  end

end

