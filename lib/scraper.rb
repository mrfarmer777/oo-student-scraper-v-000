require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html=open_uri(index_url)
    nokogiri
  end

  def self.scrape_profile_page(profile_url)

  end

end
