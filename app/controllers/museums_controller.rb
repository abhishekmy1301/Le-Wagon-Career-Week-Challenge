require 'json'
require 'open-uri'

class MuseumsController < ApplicationController
  def index
    long = params[:long]
    lat = params[:lat]
    request = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?type=poi&proximity=#{long},#{lat}&access_token=#{MAPBOX_API_KEY}"
    @data = results(request)['features']

    @museums = format_museums(@data)
  end

  def format_museums(data)
    Museum.destroy_all
    museums = []
    data.each do |museum|
      museums << Museum.create(name: museum['text'], postcode: museum['context'][0]['text'])
    end
    museums
  end

  private

  def results(request)
    response = URI.open(request)
    JSON.parse(response.read)
  end
end
