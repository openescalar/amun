class Oecloud 	
	require 'cgi'
	require 'time'
	require 'uri'
        require 'openssl'
        require 'net/ssh'
	require 'base64'
	require 'net/http'
	require 'net/https'
	require 'rexml/document'
        require 'xmlrpc/client'

	def initialize(args)
		@thezone	= args[:zone] || ""
		@theimage	= args[:image] || ""
		@theserver	= args[:server] || ""
		@theoffer    	= args[:offer] || ""
		@thefirewall 	= args[:firewall] || ""
		@thevolume   	= args[:volume] || ""
		@thekey   	= args[:keypair] || ""
		@theloadbalancer = args[:loadbalancer] || ""
		@therule	= args[:rule] || ""
		@key	  	= args[:key] || ""
		@secret   	= args[:secret] || ""
		case @thezone.apitype
		when "EUCA"
			extend Eucaapi
			@parameters = {
                                 'AWSAccessKeyId'       => @key,
                                 'SignatureMethod'      => 'HmacSHA256',
                                 'SignatureVersion'     => 2,
                                 'Version'              => '2009-04-04'
                        }
		when "AWS"
			extend Awsapi
                        @parameters = {
                                 'AWSAccessKeyId'       => @key,
                                 'SignatureMethod'      => 'HmacSHA256',
                                 'SignatureVersion'     => 2,
                                 'Version'              => '2011-12-15'
                        }
		when "OSNOVA"
			extend Osapi
                        checkToken(@thezone)
                when "HPOS"
			extend Hpos
			checkToken(@thezone)
		when "RS"
			extend Rsapi
			rshttp = Net::HTTP.new('auth.api.rackspacecloud.com',443)
			rshttp.use_ssl = true
			rspath = "/v1.0"
			rsauthheaders = { 'X-Auth-User' => @keyr, 'X-Auth-Key' => @secret }
			rsresp = rshttp.get(rspath, rsauthheaders)
			@rsAuthToken = rsresp["x-auth-token"]
			@rsMgmtPath = URI.parse(rsresp["x-server-management-url"]).path
			@rsServer = "servers.api.rackspacecloud.com"
			rshttp = nil
			rspath = nil
			rsauthheaders = nil
			extend Rsapi
                when "RSOPEN"
                        extend Rsosapi
                        checkToken(@thezone)
		when "CS"
		when "COB"
		when "OEA"
		when "TEST"
		end
	end


end 
