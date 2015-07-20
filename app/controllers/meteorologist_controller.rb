require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================
    require 'json'
    google_map_api_url = 'https://maps.googleapis.com/maps/api/geocode/json?address='
    parsed_data = JSON.parse(open(google_map_api_url + url_safe_street_address + '&sensor=false').read)
    location = parsed_data["results"][0]["geometry"]["location"]

    lat = location["lat"].to_s
    lng = location["lng"].to_s

    google_weather_api_url = 'https://api.forecast.io/forecast/bc93d31f9fd224657f564034868b66b4/'
    parsed_data = JSON.parse(open(google_weather_api_url + lat + ',' + lng).read)

    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
