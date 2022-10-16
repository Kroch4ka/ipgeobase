# frozen_string_literal: true

require_relative "ipgeobase/version"
require "httparty"
require "happymapper"

# This module allows you to get meta information by ip
module Ipgeobase
  class Error < StandardError; end

  class IPMeta
    include HappyMapper

    tag "query"
    element :city, String, tag: "street"
    element :country, String, tag: "country"
    element :countryCode, String, tag: "countryCode"
    element :lat, Float, tag: "lat"
    element :lon, Float, tag: "lon"
  end

  def self.lookup(ip)
    uri = "http://ip-api.com/json/#{ip}"
    request = HTTParty.get(uri)
    IPMeta.parse(request.body, single: true)
  end
end
