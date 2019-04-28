require 'pry'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
    end

 
    #binding.pry
    @@all << self
    #binding.pry
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      Student.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
      attributes_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    self
  end

  def self.all
    @@all
  end
end




  # @name = student_hash[:name]
  #   @location = student_hash[:location]
  #   @twitter = student_hash[:twitter] if student_hash[:twitter]
  #   @linkedin = student_hash[:linkedin] if student_hash[:linkedin]
  #   @github = student_hash[:github] if student_hash[:github]
  #   @blog = student_hash[:blog] if student_hash[:blog]
  #   @profile_quote = student_hash[:profile_quote] if student_hash[:profile_quote]
  #   @bio = student_hash[:bio] if student_hash[:bio]
  #   @profile_url = student_hash[:profile_url] if student_hash[:profile_url]











