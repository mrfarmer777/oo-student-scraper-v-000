require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  #student: .student-card
  #student name: .student-card .card-text-container .student-name
  #student name: .student-card .card-text-container .student-location
  #student profile url .student-card a (get attrinbute, href)


  def self.scrape_index_page(index_url)
    scraped_stus = []
    html=open(index_url)
    doc=Nokogiri::HTML(html)
    student_data=doc.css(".student-card")
    binding.pry
    student_data.each do |student|
      name = student.css('.card-text-container .student-name').text
      location=student.css('.card-text-container .student-location').text
      binding.pry
      stu_hash={name: name, location:location}
      scraped_stus<<stu_hash
    end
    scraped_stus
  end

  def self.scrape_profile_page(profile_url)

  end

end
