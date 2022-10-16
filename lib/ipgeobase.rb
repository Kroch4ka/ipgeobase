# frozen_string_literal: true

require_relative "ipgeobase/version"
require "httparty"
require "happymapper"

module Ipgeobase
  class Error < StandardError; end

  def self.lookup(ip)
    uri = "http://ip-api.com/json/#{ip}"
    request = HTTParty.get(uri)
    HappyMapper.parse(request.body)
  end
end
