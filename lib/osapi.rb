module Osapi
## queryOS(:component => 'Nova', :entrypoint => 'http://server.com:8774/v2/asdkjflqkjlksdlkflk23lk24123', :method => 'get', :path => "/images"

### OpenStack     Functions ###
  def allocateaddress
    if not checkRequirements(["thezone"])
      return false
    end
    checkToken(@thezone)
    req = JSON '{}'
    data = queryOS(:component => "Nova", :entrypoint => @theserver.azone.endpoint, :request => req.to_json, :method => "post", :path => "#{@thezone.tenant}/os-floating-ips", :token => @thezone.token )
    data ? data["floating_ip"]["ip"] : false
  end

  def associateaddress
    false
  end

  def authorizedsecuritygroupingress
    if not checkRequirements(["thezone","thefirewall","therule"])
      return false
    end
    checkToken(@thezone)
    req = JSON '{"security_group_rule":{"ip_protocol":"' + @therule.protocol + '", "from_port":"' + @therule.fromport.to_s + '", "to_port":"' + @therule.toport.to_s + '","parent_group_id":"' + @thefirewall.serial + '", "cidr" : "' + @therule.source + '"}}'
    data = queryOS(:component => "Nova", :entrypoint => @thefirewall.azone.endpoint, :request => req.to_json, :method => "post", :path => "#{@thezone.tenant}/os-security-group-rules", :token => @thezone.token )
    data ? data["security_group_rule"]["id"] : false
  end

  def attachvolume 
    if not checkRequirements(["thezone","theserver","thevolume"]) 
       return false
    end
    checkToken(@thezone)
    req = JSON '{"volumeAttachment":{"volume_id":"' + @thevolume.serial + '", "device":"' + @thevolume.device + '"}}'
    data = queryOS(:component => "Nova", :entrypoint => @thevolume.azone.endpoint, :request => req.to_json, :method => "post", :path => "#{@thezone.tenant}/servers/" + @theserver.serial + "/os-volume_attachments", :token => @thezone.token )
    data ? data : false
  end

  def createimage
    false
  end

  def createkeypair
    if not checkRequirements(["thezone","thekey"])
      return false
    end
    checkToken(@thezone)
    req = JSON '{"keypair":{"name":"' + @thekey.name + '"}}'
    data = queryOS(:component => "Nova", :entrypoint => @thekey.azone.endpoint, :request => req.to_json, :method => "post", :path => "#{@thezone.tenant}/os-keypairs", :token => @thezone.token )
    data ? data["keypair"]["private_key"] : false
  end

  def createsecuritygroup
    if not checkRequirements(["thezone","thefirewall"])
      return false
    end
    checkToken(@thezone)
    req = JSON '{"security_group":{"name":"' + @thefirewall.name + '", "description":"' + @thefirewall.description + '"}}'
    data = queryOS(:component => "Nova", :entrypoint => @thefirewall.azone.endpoint, :request => req.to_json, :method => "post", :path => "#{@thezone.tenant}/os-security-groups", :token => @thezone.token )
    data ? data["security_group"]["id"] : false
  end

  #def createsnapshot
  #end

  def createvolume
    if not checkRequirements(["thezone","thevolume"])
      return false
    end
    checkToken(@thezone)
    req = JSON '{"volume":{"display_name":"' + @thevolume.name + '", "display_description":"' + @thevolume.description + '", "size":"' + @thevolume.size.to_s + '", "availability_zone":"' + @thevolume.azone.name + '"}}'
    data = queryOS(:component => "Nova", :entrypoint => @thevolume.azone.endpoint, :request => req.to_json, :method => "post", :path => "#{@thezone.tenant}/volumes", :token => @thezone.token )
    data ? data["volume"]["id"] : false
  end

  def deletekeypair
   if not checkRequirements(["thezone","thekey"])
      return false
    end
    checkToken(@thezone)
    data = queryOS(:component => "Nova", :entrypoint => @thekey.azone.endpoint, :method => "delete", :path => "#{@thezone.tenant}/os-keypairs/" + @thekey.name, :token => @thezone.token )
    data ? data : false
  end

  def deletesecuritygroup
    if not checkRequirements(["thezone","thefirewall"])
      return false
    end
    checkToken(@thezone)
    data = queryOS(:component => "Nova", :entrypoint => @thefirewall.azone.endpoint, :method => "delete", :path => "#{@thezone.tenant}/os-security-groups/" + @thefirewall.serial, :token => @thezone.token )
    data ? data : false
  end

  #def deletesnapshot
  #end

  def deletevolume
    if not checkRequirements(["thezone","thevolume"])
      return false
    end
    checkToken(@thezone)
    data = queryOS(:component => "Nova", :entrypoint => @thevolume.azone.endpoint, :method => "delete", :path => "#{@thezone.tenant}/volumes/" + @thevolume.serial, :token => @thezone.token )
    data ? data : false
  end

  def deregisterimage
    if not checkRequirements(["thezone","theimage"])
      return false
    end
    p = "/images/" + theimage.serial
    data = queryOS(:component => "Nova", :entrypoint => theimage.azone.endpoint, :path => p, :method => "delete" )
    data ? data : false
  end

  #def describeaddresses
  #end

  def describeimages
    if not checkRequirements(["thezone"])
      return false
    end
    checkToken(@thezone)
    data = queryOS(:component => "Nova", :entrypoint => @thezone.azones.first.endpoint, :method => "get", :path => @thezone.tenant + "/images", :token => @thezone.token )
    data ? getResources("images",data,{:id => "id", :name => "name", :description => "name", :arch => "arch"}, {:arch => "x86_64"}) : false
  end

  def describeinstances()
    if not checkRequirements(["thezone","theserver"])
      return false
    end
    checkToken(@thezone)
    data = queryOS(:component => "Nova", :entrypoint => @theserver.azone.endpoint, :method => "get", :path => "#{@thezone.tenant}/servers/#{@theserver.serial}" + , :token => @thezone.token )
    data ? getResources("servers",data,{:addresses => "addresses" }, nil) : false
  end

  #def describekeypairs
  #end

  def describesecuritygroups
    if not checkRequirements(["thezone"])
      return false
    end
    checkToken(@thezone)
    data = queryOS(:component => "Nova", :entrypoint => @thezone.azones.first.endpoint, :method => "get", :path => @thezone.tenant + "/os-security-groups", :token => @thezone.token )
    data ? getResources("os-security-groups",data,{:id => "id", :name => "name", :description => "description"}, nil) : false
  end

  def describerules(fw)
    if not checkRequirements(["thezone"])
      return false
    end
    checkToken(@thezone)
    data = queryOS(:component => "Nova", :entrypoint => @thezone.azones.first.endpoint, :method => "get", :path => @thezone.tenant + "/os-security-groups/" + fw.to_s, :token => @thezone.token )
    data ? getResources("rules",data,{:fromport => "from_port", :protocol => "ip_protocol", :toport => "to_port", :source => "ip_range"}, nil) : false
  end


  #def describesnapshots
  #end

  def describevolumes
    if not checkRequirements(["thezone"])
      return false
    end
    checkToken(@thezone)
    data = queryOS(:component => "Volume", :entrypoint => @thezone.azones.first.endpoint, :method => "get", :path => @thezone.tenant + "/os-volumes", :token => @thezone.token )
    data ? getResources("volumes",data,{:id => "id", :name => "display_name", :description => "display_description", :availability => "availability_zone", :size => "size"}, nil) : false
  end

  def detachvolume
    if not checkRequirements(["thezone","theserver","thevolume"]) 
       return false
    end
    checkToken(@thezone)
    data = queryOS(:component => "Nova", :entrypoint => @thevolume.azone.endpoint, :method => "delete", :path => "#{@thezone.tenant}/servers/" + theserver.serial + "/os-volume_attachments/" + thevolume.serial, :token => @thezone.token )
    data ? data : false
  end

  def disassociateaddress
    false
  end

  def importkeypair
    if not checkRequirements(["thezone","thekey"])
      return false
    end
    checkToken(@thezone)
    req = JSON '{"keypair":{"name":" + @thekey.name + ","public_key":" + @thekey.public + "}}'
    data = queryOS(:component => "Nova", :entrypoint => @thekey.azone.endpoint, :request => req.to_json, :method => "post", :path => "#{@thezone.tenant}/os-keypairs", :token => @thezone.token )
    data ? data["keypair"]["fingerprint"] : false
  end

  def rebootinstances
    if not checkRequirements(["thezone","theserver"])
      return false
    end
    checkToken(@thezone)
    p = "#{@thezone.tenant}/servers/" + @theserver.id + "/action"
    req = JSON '{"reboot":{"type":"HARD"}}'
    data = queryOS(:component => "Nova", :entrypoint => @theserver.azone.endpoint, :method => "post", :path => p, :request => req.to_json, :token => @thzone.token )
    data ? data : false
  end

  def registerimage
  end

  def releaseaddress
    if not checkRequirements(["thezone","theip"])
      return false
    end
    checkToken(@thezone)
    p = "#{@thezone.tenant}/os-floating-ips/" + @theip.serial
    req = JSON '{}'
    data = queryOS(:component => "Nova", :entrypoint => @theip.azone.endpoint, :method => "delete", :path => p, :token => @thezone.token )
    data ? data : false
  end

  def revokesecuritygroupingress
    if not checkRequirements(["thezone","thefirewall","therule"])
      return false
    end
    checkToken(@thezone)
    data = queryOS(:component => "Nova", :entrypoint => @thefirewall.azone.endpoint, :method => "delete", :path => "#{@thezone.tenant}/os-security-group-rules/" + @therule.serial, :token => @thezone.token )
    data ? data : false
  end

  def runinstances
    if not checkRequirements(["thezone","theserver","theimage","theoffer"])
      return false
    end
    checkToken(@thezone)
    req = JSON '{"server":{"name":"' + @theserver.fqdn + '", "imageRef":"' + @theimage.serial + '", "flavorRef":"' + @theoffer.code + '"}}'
    data = queryOS(:component => "Nova", :entrypoint => @theserver.azone.endpoint, :request => req.to_json, :method => "post", :path => "#{@thezone.tenant}/servers", :tokent => @thezone.token )
    data ? data["server"]["id"] : false
  end

  def startinstances
    false
  end

  def stopinstances
    false
  end

  def terminateinstances
    if not checkRequirements(["thezone","theserver"])
      return false
    end
    checkToken(@thezone)
    p = "#{@thezone.tenant}/servers/" + @theserver.serial
    data = queryOS(:component => "Nova", :entrypoint => @theserver.azone.endpoint, :method => "delete", :path => p, :token => @thezone.token )
    data ? data : false
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

## queryOS(:component => 'Nova', :entrypoint => 'http://server.com:8774/v2/asdkjflqkjlksdlkflk23lk24123', :method => 'get', :path => "/images"

  def queryOS(args)
    begin
     p = Hash.new
     uri = URI(args[:entrypoint])
     p["header"] = {'Content-type'=>'application/json','Accept-type'=>'application/json','X-Auth-Token'=>args[:token]}
     case args[:component].to_s
      when "Nova"
        p["port"] = uri.port || 8774
	p["path"] = uri.path
      when "Glance"
        p["port"] = uri.port || 9292
        p["path"] = uri.path || "/v1"
      when "Volume"
        p["port"] = uri.port || 8776
	p["path"] = uri.path
      when "Swift" 
        p["port"] = uri.port || 8080
	p["path"] = uri.path
      when "Keystone"
        p["port"] = uri.port || 35357
        p["path"] = uri.path || "/v2/tokens"
      when "Cloud"
        p["port"] = uri.port || 8773
        p["path"] = uri.path || "/services/Cloud"
        p["header"] = {'Content-type'=>'application/xml','Accept-type'=>'application/xml'}
      else
        return false
     end
     p["location"] = uri.host || ""
     p["path"] = p["path"] + args[:path] || uri.path
     p["request"] = args[:request] || ""
     os = Net::HTTP.new(p["location"],p["port"])
     if uri.scheme == "https"
       os.use_ssl = true
     else
       os.use_ssl = false
     end
     resp = nil
     case args[:method].to_s
      when "post"
        resp = os.post(p["path"], p["request"], p["header"])
      when "get"
        resp = os.get(p["path"], p["header"])
      when "update"
        resp = os.put(p["path"], p["request"], p["header"])
      when "delete"
        resp = os.delete(p["path"], p["header"])
     end
     newdata = false
     if resp.code.to_i >= 200 and resp.code.to_i < 300
       if args[:component].to_s == "Cloud"
          newdata = resp.body
       else
	  if args[:method].to_s == "delete"
	    newdata = true
          else
            newdata = JSON resp.body
          end
       end
     end
     os = nil
     p = nil
     return newdata
    rescue Errno::EHOSTUNREACH
     false
    end
  end

  def queryKeystone(thezone)
      os = Net::HTTP.new(thezone.entrypoint, 35357)
      os.use_ssl = true
      path = "/v2.0/tokens"
      typeheader = {'Content-type'=>'application/json'}
      cred = JSON '{"auth":{"passwordCredentials":{"username":"' + thezone.key + '","password":"' + thezone.secret + '"},"tenantId":"' + thezone.tenant + '"}}'
      resp = os.post(path, cred.to_json, typeheader)
      if resp.code == "200"
        newdata = JSON resp.body
        return newdata
      else
        return false
      end
  end

  def checkToken(thezone)
    timeexp = false
    puts thezone.tokenexp
    if thezone.tokenexp == nil
      timeexp = true
    elsif thezone.tokenexp.to_time < Time.now.utc 
      timeexp = true
    end
    if timeexp
      #Requset a new token
      case thezone.apitype
         when "RSOPEN"
             port = 443
         else
             port = 35357
      end
      os = Net::HTTP.new(thezone.entrypoint, port)
      os.use_ssl = true
      path = "/v2.0/tokens"
      typeheader = {'Content-type'=>'application/json'}
      cred = JSON '{"auth":{"passwordCredentials":{"username":"' + thezone.key + '","password":"' + thezone.secret + '"},"tenantId":"' + thezone.tenant + '"}}'
      resp = os.post(path, cred.to_json, typeheader)
      if resp.code == "200"
        newdata = JSON resp.body
        puts resp.body
        thezone.tokenexp = newdata["access"]["token"]["expires"]
        thezone.token = newdata["access"]["token"]["id"]
        thezone.save
      end
    end
  end

  def getResources(path, resp, resor, forced)
    if resp
      a = Array.new
      case path
         when "rules"
           resp["security_groups"]["rules"].each do |d|
             h = Hash.new
             resor.each do |k,v|
               if k == "source" 
                 t = d["ip_range"]["cidr"]
               else
                 t = d[v]
               end
               h[k] = t.to_s if t
             end
             a << h
           end 
         when "servers"
	   resp["server"].each do |d|
	     h = Hash.new
	     resor.each do |k,v|
		case k
		   when "addresses"
			t = d["addresses"]["private"][1]["addr"]
		   else
		end
		h[k] = t.to_s if t	
	     end
	    a << h
           end
         else
           resp[path].each do |d|
             h = Hash.new
             resor.each do |k,v|
               t = d[v]
               h[k] = t.to_s if t
               if not forced.nil?
	         h[k] = forced[k] if forced.has_key?(k)
	       end
             end
             a << h
           end
       end
      a
    else
      false
    end
  end

end
