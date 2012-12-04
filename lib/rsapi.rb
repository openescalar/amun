module Rsapi

########################## IMPORT FUNCTIONS

  def importimages
    if not checkRequirements(["thezone"])
      return false
    end
    upath = @rsMgmtPath + "/images" 
    xmlrequest = nil
    r = queryCloud("get", upath, xmlrequest)
    Hash.from_xml(r.body)
  end

  def importservers
    if not checkRequirements(["thezone"])
      return false
    end
    upath = @rsMgmtPath + "/servers"
    xmlrequest = nil
    r = queryCloud("get", upath, xmlrequest)
    Hash.from_xml(r.body)
  end

  def importvolumes
    false
  end

  def importfirewalls
    false
  end

  def importlb
    upath = @rsMgmtPath + "/servers/" + serverid
    xmlrequest = nil
    r = queryCloud("get", upath, xmlrequest)
    Hash.from_xml(r.body)
  end

### RS     Functions ###
  def allocateaddress
    false
  end

  def associateaddress
    false
  end

  def authorizedsecuritygroupingress
    false
  end

  def createimage
    false
  end

  def createkeypair
    false
  end

  def createsecuritygroup
    false
  end

  #def createsnapshot
  #end

  def createvolume
    false
  end

  def deletekeypair
    false
  end

  def deletesecuritygroup
    false
  end

  #def deletesnapshot
  #end

  def deletevolume
    false
  end

  def deregisterimage
    if not checkRequirements(["thezone","theimage"])
      return false
    end
    upath = @rsMgmtPath + "/images/" + @theimage.serial
    xmlrequest=""
    r = queryCloud("delete", upath, xmlrequest)
    parseQuery("delete", r, "image")
  end

  #def describeaddresses
  #end

  #def describeimages
  #end

#  def describeinstances(attribute)
#    if not checkRequirements(["thezone"])
#      return false
#    end
#
#    upath = @rsMgmtPath + "/servers/" + serverid
#    xmlrequest = nil
#    r = queryCloud("get", upath, xmlrequest)
#    parseQuery("status", r)
#  end

  #def describekeypairs
  #end

  #def describesecuritygroups
  #end

  #def describesnapshots
  #end

  #def desbribevolumes
  #end

  def detachvolume
    false
  end

  def disassociateaddress
    false
  end

  def importkeypair
    false
  end

  def rebootinstances
    if not checkRequirements(["thezone","theserver"])
      return false
    end
    upath = @rsMgmtPath + "/servers/" + @theserver.serial + "/action"
    xmlrequest = "<reboot xmlns=\"http://docs.rackspacecloud.com/servers/api/v1.0\" type=\"HARD\" />\n"
    r = queryCloud("post", upath, xmlrequest)
    parseQuery("reboot", r, "server")
  end

  #def registerimage
  #  upath = @rsMgmtPath + "/images"
  #  xmlrequest = "<image xmlns=\"http://docs.rackspacecloud.com/servers/api/v1.0\" name=\"#{@image.name}\" serverId=\"#{@server.serial}\" />\n"
  #  r = queryCloud("post", upath, xmlrequest)
  #  parse_rs_query("id", r)
  #end

  def releaseaddress
    false
  end

  def revokesecuritygroupingress
    false
  end

  def runinstances
    if not checkRequirements(["thezone","theserver","theimage","theoffer"])
      return false
    end
    upath = @rsMgmtPath + "/servers"
    xmlrequest = "<server xmlns=\"http://docs.rackspacecloud.com/servers/api/v1.0\" name=\"#{@theserver.fqdn}\" imageId=\"#{@theimage.serial}\" flavorId=\"#{@theoffer.code}\"><personality><file path=\"/etc/oetype\">" + Base64.encode64('RS' ) + "</file></personality></server>\n"
    r = queryCloud("post", upath, xmlrequest)
    parseQuery("create", r, "server")
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
    upath = @rsMgmtPath + "/servers/" + @theserver.serial
    xmlrequest = nil
    r = queryCloud("delete", upath, xmlrequest)
    parseQuery("delete", r, "server")
  end

###########################################LOAD BALANCER SECTION

  def createloadbalancer
    return false
    if not checkRequirements(["thezone","theloadbalancer"])
      return false
    end
    upath = @rsMgmtPath + "/loadbalancers"
    xmlrequest = "<loadBalancer xmlns=\"http://docs.openstack.org/loadbalancers/api/v1.0\"
    name=\"#{@theloadbalancer.name}\"
    port=\"#{@theloadbalancer.port}\"
    protocol=\"#{@theloadbalancer.protocol}\">
    <virtualIps>
        <virtualIp type=\"PUBLIC\"/>
    </virtualIps>
</loadBalancer>"
   r = queryCloud("post", upath, xmlrequest)
   parseQuery("create", r)

  end

  def configurehealthcheck
    false
  end

  def createloadbalancerlistener
    false 
  end

  def deleteloadbalancer
    return false
    if not checkRequirements(["thezone","theloadbalancer"])
      return false
    end
    upath = @rsMgmtPath + "/loadbalancers/" + @theloadbalancer.serial
    xmlrequest = nil
    r = queryCloud("delete", upath, xmlrequest)
    parseQuery("delete",r)
  end

  def deleteloadbalancerlistener
    false
  end

  def descbribeloadbalancer
    false
  end

  def enableavailabilityzone
    false
  end

  def disableavailabilityzone
    false
  end

  def registerserverwithlb
    return false
    if not checkRequirements(["thezone","theloadbalancer","theserver"])
      return false
    end
    upath = @rsMgmtPath + "/loadbalancers/" + @theloadbalancer.serial + "/nodes"
    xmlrequest = "<nodes xmlns=\"http://docs.openstack.org/loadbalancers/api/v1.0\">
    <node address=\"#{@theserver.pip}\" port=\"#{@theloadbalancer.serverport}\" condition=\"ENABLED\" />
</nodes>"
    r = queryCloud("post", upath, xmlrequest)
    parseQuery("create", r)
  end

  def deregisterserverwithlb
    return false
    if not checkRequirements(["thezone","theloadbalancer","theserver"])
      return false
    end
    upath = @rsMgmtPath + "/loadbalancers/" + @theloadbalancer.serial + "/nodes"
    r = queryCloud("get", upath, nil)
    r1 = false
    if r.code.to_i < 399
      h = Hash.from_xml(r.body)
      h["nodes"]["node"].each do |n|
        if n["address"] == @theserver.pip
           upath = @rsMgmtPath + "/loadbalancers/" + @theloadbalancer.serial + "/nodes/" + n["id"]
           r2 = queryCloud("delete", upath, nil)
           r1 = parseQuery("delete", r2)
        end
      end
    end
    return r1
  end


#######################################################################


  def parseQuery(action, r, obj)
   if r
    if r.code.to_i > 399
      false
    else
      case action
      when "create"
        h = Hash.from_xml(r.body)
        h[obj]["id"]
      when "delete"
        true
      when "read"
      else
        true
      end
    end
   else
    false
   end
  end

  def checkRequirements(args)
    varmis = true
    args.each do |var|
      eval "if not @#{var}
            varmis = false
          end"
    end
    return varmis
  end

  def queryCloud(verb, uripath, xmlrequest=nil)
   begin
    rs_auth_headers = { 'Content-Type' => "application/xml", 'Accept' => "application/xml", 'X-Auth-Token' => @rsAuthToken }
    rshttp = Net::HTTP.new(@rsServer,443)
    rshttp.use_ssl = true
    ans = ""
    case verb
    when "create"
      ans = oshttp.post(uripath, xmlrequest, os_auth_headers)
    when "delete"
      ans = oshttp.delete(uripath, os_auth_headers)
    when "update"
    when "read"
      ans = oshttp.get(uripath, os_auth_headers)
    end
    return ans
   rescue Errno::EHOSTUNREACH
    false
   end
  end

end
