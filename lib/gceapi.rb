module Gceapi

### NOTE Google relies on name to keep track of your assets, in order not to create conflicts with OpenEscalar names, we'll add the oe- prefix to the actual name and use that as google name which will store in the serial
### queryGCE(:path => '/something/bla/blabla/bla', :method => 'get', :options => "extra optiones required by the url to query", :data => "{json to send}")
### Google Compute Engine     Functions ###

# on Region basis
  def allocateaddress
    if not checkRequirements(["thezone", "theip"])
      return false
    end
    checkToken(@thezone)
    req = {}
    req["name"] => @theip.name
    submit = queryGCE(:path => '/compute/v1beta15/projects/#{@thezone.name}/regions/#{@thezone.name}/addresses', :method => 'post', :options => '', :data => req.to_json, :access_token => @thezone.token )
    d = checkQuery(:type => 'region', :token => @thezone.token, :projectname => @thezone.name, :region => @thezone.name, :operationname => submit["name"])
    data = queryGCE(:path => '/compute/v1beta15/projects/#{@thezone.name}/regions/#{@thezone.name}/addresses/#{@theip.name}', :method => 'get', :options => '', :access_token => @thezone.token) if d
    data ? data["address"] : false
  end

# on Region basis
  def associateaddress
    false
  end

# on global basis
  def authorizedsecuritygroupingress
    if not checkRequirements(["thezone","thefirewall"])
      return false
    end
    checkToken(@thezone)
    req = {}
    req["name"] = @thefirewall.name
    req["sourceRanges"] = []
    req["allowed"] = []
    @thefirewall.rules.each {|r| req["sourceRanges"] << r.source }
    @thefirewall.rules.each {|r| req["allowed"] << {"IPProtocol" => r.protocol, "ports" => [r.toport]}}
    req["network"] = "http://www.googleapis.com/compute/v1beta15/project/<project-id>/global/networks/default"
    submit = queryGCE(:path => '/compute/v1beta15/projects/#{@thezone.name}/global/firewalls/#{@thefirewall.name}', :method => 'put', :options => '', :data => req.to_json, :access_token => @thezone.token)
    checkQuery(:type => 'global', :token => @thezone.token, :projectname => @thezone.name, :operationname => submit["name"])
  end

# on zone basis
  def attachvolume 
    if not checkRequirements(["thezone","theserver","thevolume"]) 
       return false
    end
    checkToken(@thezone)
    req = {}
    req["type"] = "PERSISTENT"
    req["mode"] = "READ_WRITE"
    req["source"] = @thevolume.serial
    req["boot"] = false
    submit = queryGCE(:path => '/compute/v1beta15/projects/#{@thezone.name}/zones/#{@theserver.azone.name}/instances/#{@theserver.name}/attachDisk', :method => 'post', :options => '', :data => req.to_json, :access_token => @thezone.token)
    checkQuery(:type => 'zone', :token => @thezone.token, :projectname => @thezone.name, :zonename => @theserver.azone.name, :operationname => submit["name"])
  end

# on global basis
  def createimage
    false
  end

# 
#  def createkeypair
#    if not checkRequirements(["thezone","thekey"])
#      return false
#    end
#    checkToken(@thezone)
#    req = JSON '{"keypair":{"name":"' + @thekey.name + '"}}'
#    data = queryGCE()
#    data ? data["floating_ip"]["ip"] : false
#  end

# on global basis
  def createsecuritygroup
    if not checkRequirements(["thezone","thefirewall"])
      return false
    end
    checkToken(@thezone)
    req = {}
    req["name"] = "oe-#{@thefirewall.name}"
    req["description"] = @thefirewall.description
    req["network"] = "https://www.googleapis.com/compute/v1beta15/project/#{projectid}/global/networks/default"
    req["sourceRanges"] = ["0.0.0.0/0"]
    req["allowed"] = {"IPProtocol" => "icmp"}
    submit = queryGCE(:path => '/compute/v1beta15/projects/#{@thezone.name}/global/firewalls', :method => 'post', :options => '', :data => req.to_json, :access_token => @thezone.token )
    d = checkQuery(:type => 'global', :token => @thezone.token, :projectname => @thezone.name, :operationname => submit["name"])
    data = queryGCE(:path => '/compute/v1beta15/projects/#{@thezone.name}/global/firewalls/#{req["name"]}', :method => 'get', :options => '', :access_token => @thezone.token) if d
    data ? data["name"] : false
  end

  #def createsnapshot
  #end

# on zone basis
  def createvolume
    if not checkRequirements(["thezone","thevolume"])
      return false
    end
    checkToken(@thezone)
    req = {}
    req["name"] = "oe-#{@thevolume.name}"
    req["description"] = @thevolume.description
    req["sizeGb"] = @thevolume.size
    submit = queryGCE(:path => '/compute/v1beta15/projects/#{@thezone.name}/zones/#{@thevolume.azone.name}/disks', :method => 'post', :options => '', :data => req.to_json, :access_token => @thezone.toekn )
    d = checkQuery(:type => 'zone', :token => @thezone.token, :projectname => @thezone.name, :zonename => @thevolume.azone.name, :operationname => submit["name"])
    data = queryGCE(:path => '/compute/v1beta15/projects/#{@thezone.name}/zones/#{@thevolume.azone.name}/disks/#{req["name"]}', :method => 'get', :options => '', :access_token => @thezone.token) if d
    data ? data["name"] : false
  end

#  def deletekeypair
#   if not checkRequirements(["thezone","thekey"])
#      return false
#    end
#    checkToken(@thezone)
#    data = queryGCE()
#    data ? data["floating_ip"]["ip"] : false
#  end

# on global basis
  def deletesecuritygroup
    if not checkRequirements(["thezone","thefirewall"])
      return false
    end
    checkToken(@thezone)
    submit = queryGCE(:path => '/compute/v1beta15/projects/#{@thezone.name}/global/firewalls/#{@thefirewall.serial}', :method => 'delete', :options => '', :acces_token => @thezone.token )
    checkQuery(:type => 'global', :token => @thezone.token, :projectname => @thezone.name, :operationname => submit["name"])
  end

  #def deletesnapshot
  #end

# on zone basis
  def deletevolume
    if not checkRequirements(["thezone","thevolume"])
      return false
    end
    checkToken(@thezone)
    submit = queryGCE(:path => '/compute/v1beta15/projects/#{@thezone.name}/zones/#{@thevolume.azone.name}/disks/#{@thevolume.serial}', :method => 'delete', :options => '', :access_token => @thezone.token )
    checkQuery(:type => 'zone', :token => @thezone.token, :projectname => @thezone.name, :zonename => @thevolume.azone.name, :operationname => submit["name"])
  end

# on global basis
  def deregisterimage
    if not checkRequirements(["thezone","theimage"])
      return false
    end
    submit = queryGCE(:path => '/compute/v1beta15/projects/#{@thezone.name}/global/images/#{theimage.serial}', :method => 'delete', :options => '', :access_token => @thezone.token )
    checkQuery(:type => 'global', :token => @thezone.token, :projectname => @thezone.name, :operationname => submit["name"])
  end

  #def describeaddresses
  #end

#  def describeimages
#    if not checkRequirements(["thezone"])
#      return false
#    end
#    checkToken(@thezone)
#    data = queryGCE()
#    data ? data["floating_ip"]["ip"] : false
#  end

  def getserverstatus()
    if not checkRequirements(["thezone","theserver"])
      return false
    end
    checkToken(@thezone)
    data = queryGCE(:path => '/compute/v1beta15/projects/#{@thezone.name}/zones/#{@theserver.azone.name}/instances/#{@theserver.serial}', :method => 'get', :options => '', :access_token => @thezone.token )
    data ? data["status"] : false
  end

  #def describekeypairs
  #end

#  def describesecuritygroups
#    if not checkRequirements(["thezone"])
#      return false
#    end
#    checkToken(@thezone)
#    data = queryGCE()
#    data ? data["floating_ip"]["ip"] : false
#  end

#  def describerules(fw)
#    if not checkRequirements(["thezone"])
#      return false
#    end
#    checkToken(@thezone)
#    data = queryGCE()
##    data ? data["floating_ip"]["ip"] : false
#  end


  #def describesnapshots
  #end

#  def describevolumes
#    if not checkRequirements(["thezone"])
#      return false
#    end
#    checkToken(@thezone)
#    data = queryGCE()
#    data ? data["floating_ip"]["ip"] : false
#  end

# on zone basis
  def detachvolume
    if not checkRequirements(["thezone","theserver","thevolume"]) 
       return false
    end
    checkToken(@thezone)
    data = queryGCE(:path => '/compute/v1beta15/projects/#{@thezone.name}/zones/#{@theserver.azone.name}/instances/#{@theserver.serial}/detachDisk', :method => 'post', :options => '', :access_token => @thezone.token )
    data ? data["floating_ip"]["ip"] : false
  end

#  def disassociateaddress
#    false
#  end

#  def importkeypair
#    if not checkRequirements(["thezone","thekey"])
#      return false
#    end
#    checkToken(@thezone)
#    req = JSON '{"keypair":{"name":" + @thekey.name + ","public_key":" + @thekey.public + "}}'
#    data = queryGCE()
#    data ? data["floating_ip"]["ip"] : false
#  end

# on zone basis
  def rebootinstances
    if not checkRequirements(["thezone","theserver"])
      return false
    end
    checkToken(@thezone)
    submit = queryGCE(:path => '/compute/v1beta15/projects/#{@thezone.name}/zones/#{@theserver.azone.name}/instances/#{@theserver.serial}/reset', :method => 'post', :options => '', :access_token => @thezone.token )
    checkQuery(:type => 'zone', :token => @thezone.token, :projectname => @thezone.name, :zonename => @theserver.azone.name, :operationname => submit["name"])
  end

#  def registerimage
#  end

  def releaseaddress
    if not checkRequirements(["thezone","theip"])
      return false
    end
    checkToken(@thezone)
    submit = queryGCE(:path => '/compute/v1beta15/projects/#{@thezone.name}/regions/#{@thezone.name}/addresses/#{@theip.name}', :method => 'delete', :options => '', :access_token => @thezone.token )
    checkQuery(:type => 'region', :token => @thezone.token, :projectname => @thezone.name, :regionname => @thezone.name, :operationname => submit["name"])
  end

# on global basis
  def revokesecuritygroupingress
    if not checkRequirements(["thezone","thefirewall","therule"])
      return false
    end
    checkToken(@thezone)
    req = {}
    req["name"] = @thefirewall.serial
    req["sourceRanges"] = []
    req["allowed"] = []
    @thefirewall.rules.each {|r| req["sourceRanges"] << r.source }
    @thefirewall.rules.each {|r| req["allowed"] << {"IPProtocol" => r.protocol, "ports" => [r.toport]}}
    req["network"] = "http://www.googleapis.com/compute/v1beta15/project/#{@thezone.name}/global/networks/default"
    submit = queryGCE(:path => '/compute/v1beta15/projects/#{@thezone.name}/global/firewalls/#{@thefirewall.serial}', :method => 'put', :options => '', :data => req.to_json, :access_token => @thezone.token )
    checkQuery(:type => 'global', :token => @thezone.token, :projectname => @thezone.name, :operationname => submit["name"])
  end

# on zone basis
  def runinstances
    if not checkRequirements(["thezone","theserver","theimage","theoffer"])
      return false
    end
    checkToken(@thezone)
    req = {}
    req["machineType"] = 'https://www.googleapis.com/compute/v1beta15/projects/#{@thezone.name}/zones/#{@theserver.azone.name}/machineTypes/#{@theoffer.code}'
    req["name"] = "oe-#{@theserver.name}"
    req["image"] = 'https://www.googleapis.com/compute/v1beta15/projects/#{@thezone.name}/global/images/#{@theimage.name}'
    submit = queryGCE(:path => '/compute/v1beta15/projects/#{@thezone.name}/zones/#{@theserver.azone.name}/instances', :method => 'post', :options => '', :data => req.to_json, :access_token => @thezone.token )
    d = checkQuery(:type => 'zone', :token => @thezone.token, :projectname => @thezone.name, :zonename => @theserver.azone.name, :operationname => submit["name"])
    data = queryGCE(:path => '/compute/v1beta15/projects/#{@thezone.name}/zones/#{@theserver.azone.name}/instances/#{@theserver.serial}', :method => 'get', :options => '', :access_token => @thezone.token ) if d
    data ? data["name"] : false
  end

#  def startinstances
#    false
#  end

#  def stopinstances
#    false
#  end

# on zone basis
  def terminateinstances
    if not checkRequirements(["thezone","theserver"])
      return false
    end
    checkToken(@thezone)
    submit = queryGCE(:path => '/compute/v1beta15/projects/#{@thezone.name}/zones/#{@theserver.azone.name}/instances/#{@theserver.serial}', :method => 'delete', :options => '', :access_token => @thezone.token )
    checkQuery(:type => 'zone', :token => @thezone.token, :projectname => @thezone.name, :zonename => @theserver.azone.name, :operationname => submit["name"] )
  end

#######################################################################


  def checkRequirements(args)
    varmis = true
    args.each do |var|
      eval "if not @#{var}
            varmis = false
          end"
    end
    return varmis
  end

## queryGCE(:path => '/something/bla/blabla/bla', :method => 'get', :options => "extra optiones required by the url to query", :data => "{json to send}")

  def queryGCE(args)
    begin
     gce = NET::Http.new('www.googleapis.com', 443)
     gce.use_ssl = true
     path = args[:path].to_s + args[:options].to_s
     gceheader = { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer ' + args[:access_token]}
     case args[:method].to_s
      when "post"
        resp = gce.post(path, args[:data], gceheader)
      when "get"
        resp = gce.get(path, gceheader)
      when "update"
        resp = gce.put(path, args[:data], gceheader)
      when "delete"
        resp = gce.delete(path, gceheader)
     end
     newdata = false
     if resp.code.to_i >= 200 and resp.code.to_i < 300
        newdata = JSON resp.body
     end
     gce = nil
     return newdata
    rescue Errno::EHOSTUNREACH
     false
    end
  end

  def checkQuery(args)
    # args -> :projectname 
    # args -> :type (either zone, region or global)
    # args -> :operationname (name returned by the queryGCE)
    # args -> :zonename or :regionname  i.e. us-central1 or us-central-1a depending on the type of operation
    # args -> :token 

    apiversion = '/compute/v1beta15/projects/#{args[:projectname]}"'
    case args[:type].to_s
	when "zone"
		path = "/zones/#{args[:zonename]/operations/#{args[:operationname]"
	when "region"
                path = "/regions/#{args[:regionname]}/operations/#{args[:operationname]"
	when "global" 
                path = "/global/operations/#{args[:operationname]"
    end
    check = queryGCE(:path => path, :method => 'get', :options => '', :access_token => args[:token] )
    while check["status"] != "DONE" do
      check = queryGCE(:path => path, :method => 'get', :options => '', :access_token => args[:token] )
      sleep 1
    end
    if not check["httpErrorStatusCode"]
      return true
    else 
      return false
    end
  end

  def checkToken(thezone)
    timeexp = false
    if thezone.tokenexp == nil
      timeexp = true
    elsif thezone.tokenexp.to_time < Time.now.utc 
      timeexp = true
    end
    if timeexp
      #Requset a new token
      body = JSON.load('{"iss":"' + thezone.key + '","scope":"https://www.googleapis.com/auth/compute","aud":"https://accounts.google.com/o/oauth2/token","exp":' + (Time.now.utc.to_i + 3600).to_s + ',"iat":' + Time.now.utc.to_i.to_s + '}')
      header = JSON.load('{"alg":"RS256","typ":"JWT"}')
      data = Base64.urlsafe_encode64(header.to_json) + "." + Base64.urlsafe_encode64(body.to_json)
      digest = OpenSSL::Digest::SHA256.new
      key = OpenSSL::PKCS12.new File.read('/root/computeengine.p12'), 'notasecret'
      pkey = OpenSSL::PKey::RSA.new key.key
      signature = pkey.sign(digest,data)
      gcehttp = Net::HTTP.new('accounts.google.com', 443)
      gcehttp.use_ssl = true
      httpheaders = {'Content-Type' => 'application/x-www-form-urlencoded'}
      gcepath = '/o/oauth2/token'
      granttype = "grant_type=" + CGI.escape("urn:ietf:params:oauth:grant-type:jwt-bearer")
      request = granttype + "&assertion=" + Base64.urlsafe_encode64(header.to_json) + "." + Base64.urlsafe_encode64(body.to_json) + "." + Base64.urlsafe_encode64(signature)
      resp = gcehttp.post(gcepath, request, httpheaders)
      if resp.code == "200"
        newdata = JSON resp.body
        thezone.tokenexp = newdata["expires_in"]
        thezone.token = newdata["access_token"]
        thezone.save
      end
    end
  end

end
