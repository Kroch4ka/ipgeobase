# frozen_string_literal: true

require "test_helper"

class TestIpgeobase < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def test_parse_fields_to_instance
    response = HTTParty.get("#{@json_path}#{@test_ip}")
    instance = HappyMapper.parse(response.body)

    assert { !instance.status.nil? && (instance.status == "success" || instance.status == "fail") }
  end

  def test_lookup
    instance = Ipgeobase.lookup(@test_ip)
    assert { instance.status == 'success' && instance.lat == '45.6085' }
  end

  private

  def setup
    @test_ip = "24.48.0.1"
    @json_path = "http://ip-api.com/json/"
    @xml_body = File.read("test/fake_body.xml")
    stub_request(:get, "#{@json_path}#{@test_ip}")
      .to_return(body: @xml_body)
  end
end
