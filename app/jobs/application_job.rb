class ApplicationJob < ActiveJob::Base
  require 'nokogiri'
  require 'open-uri'
  require 'json'

  def page_data(url, css_class)
    doc = Nokogiri::HTML(URI.open(url))
    JSON.parse(doc.css(css_class)[0]['q-data'])
  end
end