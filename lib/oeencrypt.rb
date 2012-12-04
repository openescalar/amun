class Oeencrypt

  def self.decryptQuery(parameters,secret,key)
    p = Hash.new
    parameters.each do |a,b|
      p[a] = b
    end
    p['key'] = key
    p['time'] = Time.now.utc.iso8601
    bt = Time.now.utc - 1
    p.delete('signature')
    p.delete('controller')
#    p.delete('action')
    canonical_querystring = p.sort.collect { |key,value| [URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")), URI.escape(value.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))].join('=') }.join('&')
    hmac= OpenSSL::HMAC.new(secret,'sha256')
    hmac.update(canonical_querystring)
    signature = Base64.encode64(hmac.digest).chomp
    p['time'] = bt.iso8601
    canonical_querystring = p.sort.collect { |key,value| [URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")), URI.escape(value.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))].join('=') }.join('&')
    hmac= OpenSSL::HMAC.new(secret,'sha256')
    hmac.update(canonical_querystring)
    signature2 = Base64.encode64(hmac.digest).chomp
    if parameters[:signature] == signature or parameters[:signature] == signature2
     true
    else
     false
    end
  end

end
