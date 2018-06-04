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
    #binding.pry
    student_data.each do |student|
      name = student.css('.card-text-container .student-name').text
      location=student.css('.card-text-container .student-location').text
      profile_url=student.css('a').attribute("href").text
      #binding.pry
      stu_hash={name: name, location:location, profile_url:profile_url}
      scraped_stus<<stu_hash
      #binding.pry
    end
    scraped_stus
  end

  def self.scrape_profile_page(profile_url)
    html=open(profile_url)
    doc=Nokogiri::HTML(html)
    stu_hash={}
    socials=doc.css(".social-icon-container a")
    binding.pry
    socials.each do |social|
      soc_link=social.attribute("href").text
      binding.pry
      case soc_link
      when .include?('facebook')
        stu_hash[:facebook]=soc_link
      when .include?('linkedin')
        stu_hash[:linkedin]=soc_link
      end
      binding.pry
    end

    quote=doc.css("profile-quote").text
    stu_hash[:quote]=quote
    bio=doc.css("description-holder p").text
    stu_hash[:bio]=bio
    stu_hash
  end

end
