class Oehome

	require 'net/http'
	require 'rexml/document'
        def initialize(u)
		@user = u
	end
	def QueryXymon
		alerts = []
		sock = Net::HTTP.new('toolsint.zuncloud.com',80)
		path = "/xymon-cgi/xboard.sh?page=" + @user.to_s + "&color=red"
		resp = sock.get(path)
		doc = REXML::Document.new(resp.body)
		doc.root.elements.each do |alrt|
		  alerts << { :server => alrt[1].text, :test => alrt[3].text, :status => alrt[5].text }
		end
		return alerts
	end
end
