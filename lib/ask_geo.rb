require 'net/http'
require 'uri'
require 'cgi'
require 'json'

class AskGeo
  class APIError < StandardError; end

  attr_accessor :account_id, :api_key

  def initialize(opts = {})
    @account_id = opts[:account_id]
    @api_key    = opts[:api_key]
  end

  def base_url
    "http://api.askgeo.com/v1"
  end

  def serialize_point(point)
    case point
    when Hash
      "#{point[:lat]},#{point[:lon]}"
    else
      # Assume this is something whose #to_s makes a "lat,lon" string.
      point.to_s.gsub(/\s+/, '')
    end
  end

  def serialize_points(points)
    points = [points] if !points.kind_of?(Array)
    points.map{|p| serialize_point(p)}.join(';')
  end

  def format_url(points)
    "#{base_url}/#{account_id}/#{api_key}/query.json?points=#{CGI::escape(serialize_points(points))}&databases=Point,TimeZone"
  end

  def lookup(points)
    response = JSON.parse(Net::HTTP.get URI.parse(format_url(points)))
    if response['code'] != 0
      raise APIError.new(response['message'] || 'Unknown server error')
    end
    data = response['data']
    data.size == 1 ? data.first : data
  rescue JSON::ParserError
    raise APIError.new("Invalid server response")
  end
end
