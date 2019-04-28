require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = []
    doc.css("div.roster-cards-container").each do |roster|
        roster.css("div.student-card a").each do |names|
           student = {}
           student[:name] = names.css("h4.student-name").text
           student[:location] = names.css("p.student-location").text
           student[:profile_url] = names.attr("href")
           students << student
           end
        end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_info = {}
    links = []
    #binding.pry
    doc.css("div.vitals-container").each do |containers|
        containers.css("div.social-icon-container").each do |social|
           social.children.css("a").each do |site_links|
            #binding.pry
            if site_links.attr("href").include?("twitter")
              student_info[:twitter] = site_links.attr("href")
            elsif site_links.attr("href").include?("linkedin")
               student_info[:linkedin] = site_links.attr("href")
            elsif site_links.attr("href").include?("github")
               student_info[:github] = site_links.attr("href")
            else
              student_info[:blog] = site_links.attr("href")
                end
              end
           end
          student_info[:profile_quote] = containers.css("div.profile-quote").text
          
          student_info[:bio] = doc.css("div.description-holder p").text
           doc.css("div.description-holder p").text
         end
        student_info
        
      end


end
    #binding.pry
          # sites = {}
          # sites[:twitter]
          # sites[:linkedin] = names.css("h4.student-name").text
          # sites[:github] = names.css("p.student-location").text
          # sites[:blog] = names.attr("href")
          # sites[:profile_quote] = 
          # sites[:bio] = 
           
          # students << student

