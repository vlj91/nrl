class ApplicationJob < ActiveJob::Base
  require 'nokogiri' # all jobs do some sort of scraping
  require 'open-uri'
  require 'json'

  def page_data(url, css_class)
    doc = Nokogiri::HTML(URI.open(url))
    JSON.parse(doc.css(css_class)[0]['q-data'])
  end

  def competition_id
    Rails.application.config_for(:nrl)[:competition_id]
  end

  def seasons
    Rails.application.config_for(:nrl)[:seasons]
  end

  def current_season
    seasons.max
  end
end
