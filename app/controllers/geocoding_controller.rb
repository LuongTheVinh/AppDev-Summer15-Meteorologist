require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("street_to_coords_form.html.erb")
  end

  def street_to_coords
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

    @latitude = location["lat"]

    @longitude = location["lng"]

    render("street_to_coords.html.erb")
  end
end
