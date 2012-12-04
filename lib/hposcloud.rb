module Hposcloud
require 'oscloud'
include Oscloud

  def importavailablezones
    false
  end

  def createSign(parameters, location)
    parameters['Timestamp'] = Time.now.utc.iso8601
    canonical_querystring = parameters.sort.collect { |key, value| [URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")), URI.escape(value.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))].join('=') }.join('&')
    string_to_sign = "GET
#{location}
/services/Cloud/
#{canonical_querystring}"
    hmac = OpenSSL::HMAC.new(@secret,'sha256')
    hmac.update(string_to_sign)
    signature = Base64.encode64(hmac.digest).chomp
    parameters['Signature'] = signature
    querystring = parameters.sort.collect { |key, value| [URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")), URI.escape(value.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))].join('=') }.join('&')
    return querystring
  end

  def queryCloud(querys, location)
   begin
    sock = Net::HTTP.new(location,443)
    sock.use_ssl = false
    path = "/services/Cloud/?#{querys}"
    resp = sock.get(path)
    resp.body
   rescue Errno::EHOSTUNREACH
    false
   end
  end

end
