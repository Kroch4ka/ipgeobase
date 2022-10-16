# frozen_string_literal: true

require "test_helper"

class TestIpgeobase < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def test_integer_value_in_instance
    assert { @instance.lon.instance_of? Float }
  end

  def test_string_value_in_instance
    assert { @instance.countryCode == "CA" }
  end

  private

  def setup
    @test_ip = "24.48.0.1"
    @json_path = "http://ip-api.com/json/"
    @xml_body = File.read("test/fake_body.xml")
    stub_request(:get, "#{@json_path}#{@test_ip}")
      .to_return(body: @xml_body)
    @instance = Ipgeobase.lookup(@test_ip)
  end
end
