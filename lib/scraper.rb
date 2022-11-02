require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  # grab entire document from the webpage
  def get_page
    doc = Nokogiri::HTML(URI.open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
    #binding.pry
  end

  # grab html elements containing a certain course and return collection of nokogiri xml elements
  def get_courses
    self.get_page.css(".post")
  end

  # instantiate course objects and give each course the correct attribute scraped from the page
  def make_courses
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
    end
  end

  # iterate over all courses and print out a list of all course offerings
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
end

Scraper.new.print_courses


# binding.pry




