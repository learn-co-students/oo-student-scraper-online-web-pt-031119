require 'pry'
class Student
  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url
  @@all = []

  #Takes in a hash argument and sets the student's attributes
  #using key/value pairs. Adds student instance to Class @@all array.
  def initialize(student_hash)
    self.name = student_hash[:name]
    self.location = student_hash[:location]
    self.profile_url = student_hash[:profile_url]
    @@all.push(self)
  end

  #Uses the Scraper Class' scrape_index_page method's array to
  #create a new students. Initialize method takes in a hash from the array
  #and sets name, location, and profile url.
  def self.create_from_collection(students_array)
    students_array.each do |student_info|
      Student.new(student_info)
    end
  end

  #Uses the Scraper Class' scrape_profile_page method hash to
  #set a Student instance's social media attributes.
  def add_student_attributes(attributes_hash)
    self.twitter = attributes_hash[:twitter]
    self.linkedin = attributes_hash[:linkedin]
    self.bio = attributes_hash[:bio]
    self.blog = attributes_hash[:blog]
    self.github = attributes_hash[:github]
    self.profile_url = attributes_hash[:profile_url]
    self.profile_quote = attributes_hash[:profile_quote]
  end

  #Getter for all student instances.
  def self.all
    @@all
  end
end
