module Awsapi

################## EC2 SECTION #############################

  def attachvolume
    if not checkRequirements(["thezone", "thevolume", "theserver"])
       return false
    end
    @parameters['Action']="AttachVolume"
    @parameters['VolumeId']=@thevolume.serial
    @parameters['InstanceId']=@theserver.serial
    @parameters['Device']=@thevolume.device
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("status",r)
  end

  def allocateaddress
    if not checkRequirements(["thezone"])
       return false
    end
    @parameters['Action']="AllocateAddress"
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("publicIp",r)
  end

  def associateaddress
    if not checkRequirements(["thezone","theserver","theips"])
       return false
    end
    @parameters['Action']="AssociateAddress"
    @parameters['InstanceId']=@theserver.serial
    @parameters['PublicIp']=@theips.name
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("return",r)
  end

  def authorizedsecuritygroupingress
    if not checkRequirements(["thezone","thefirewall","therule"])
       return false
    end
    @parameters['Action']="AuthorizeSecurityGroupIngress"
    @parameters['GroupId']=@thefirewall.serial
    @parameters['IpPermissions.1.IpProtocol']=@therule.protocol.downcase
    @parameters['IpPermissions.1.FromPort']=@therule.fromport
    @parameters['IpPermissions.1.ToPort']=@therule.toport
    @parameters['IpPermissions.1.IpRanges.1.CidrIp']=@therule.source
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("return",r)
  end

  def createimage
    if not checkRequirements(["thezone","theserver","theimage"])
       return false
    end
    @parameters['Action']="CreateImage"
    @parameters['InstanceId']=@theserver.serial
    @parameters['Name']=@theimage.name
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("imageId",r)
  end

  def createkeypair
    if not checkRequirements(["thezone","thekey"])
       return false
    end
    @parameters['Action']="CreateKeyPair"
    @parameters['KeyName']=@thekey.name
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("keyMaterial",r)
  end

  def createsecuritygroup
    if not checkRequirements(["thezone","thefirewall"])
       return false
    end
    @parameters['Action']="CreateSecurityGroup"
    @parameters['GroupName']=@thefirewall.name
    @parameters['GroupDescription']=@thefirewall.description
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("groupId",r)
  end

  #def createsnapshot
  #  q = createSign(@parameters, @thezone.entrypoint)
  #  r = queryCloud(q, @thezone.entrypoint)
  #  parseQuery("instancesSet/item/instanceId",r)
  #end

  def createvolume
    if not checkRequirements(["thezone","thevolume"])
       return false
    end
    @parameters['Action']="CreateVolume"
    @parameters['Size']=@thevolume.size
    @parameters['AvailabilityZone']=@thevolume.azone.name
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("volumeId",r)
  end

  def deletekeypair
    if not checkRequirements(["thezone","thekey"])
       return false
    end
    @parameters['Action']="DeleteKeyPair"
    @parameters['KeyName']=@thekey.name
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("return",r)
  end

  def deletesecuritygroup
    if not checkRequirements(["thezone","thefirewall"])
       return false
    end
    @parameters['Action']="DeleteSecurityGroup"
    @parameters['GroupName']=@thefirewall.name
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("return",r)
  end

  #def deletesnapshot
  #  @parameters['Action']="deletesnapshot"
  #  q = createSign(@parameters, @thezone.entrypoint)
  #  r = queryCloud(q, @thezone.entrypoint)
  #  parseQuery("instancesSet/item/instanceId",r)
  #end

  def deletevolume
    if not checkRequirements(["thezone","thevolume"])
       return false
    end
    @parameters['Action']="DeleteVolume"
    @parameters['VolumeId']=@thevolume.serial
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("return",r)
  end

  def deregisterimage
    if not checkRequirements(["thezone","theimage"])
       return false
    end
    @parameters['Action']="DeregisterImage"
    @parameters['ImageId']=@theimage.serial
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("return",r)
  end

  #def describeaddresses
   # @parameters['Action']="DescribeAddresses"
   # q = createSign(@parameters, @thezone.entrypoint)
   # r = queryCloud(q, @thezone.entrypoint)
   # parseQuery("instancesSet/item/instanceId",r)
  #end

  def describeimages
    if not checkRequirements(["thezone"])
       resturn false
    end
    @parameters['Action']="DescribeImages"
    @parameters['Owner.1']="self"
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    getResources('//imagesSet/item',r,{:id => "imageId", :description => "description", :arch => "architecture"})
  end

  def getserverstatus()
    if not checkRequirements(["thezone","theserver"])
       return false
    end
    @parameters['Action']="DescribeInstances"
    @parameters['InstanceId.1']=@theserver.serial
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    return parseQuery("reservationSet/item/instancesSet/item/ipAddress",r), parseQuery("reservationSet/item/instancesSet/item/instanceState/code",r), parseQuery("reservationSet/item/instancesSet/item/dnsName",r)
  end

  #def describekeypairs
  #  @parameters['Action']="DescribeKeyPairs"
  #  @parameters['KeyName.1']=@keypair.name
  #  q = createSign(@parameters, @thezone.entrypoint)
  #  r = queryCloud(q, @thezone.entrypoint)
  #  parseQuery("instancesSet/item/instanceId",r)
  #end

  def describesecuritygroups
    if not checkRequirements(["thezone"])
       resturn false
    end
    @parameters['Action']="DescribeSecurityGroups"
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    getResources('//securityGroupInfo/item',r,{:id => "groupId", :name => "groupName", :description => "groupDescription"})
  end

  def describerules(fwid)
    if not checkRequirements(["thezone"])
       resturn false
    end
    @parameters['Action']="DescribeSecurityGroups"
    @parameters['GroupId.1']=fwid
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    getResources('//securityGroupInfo/item/ipPermissions/item',r,{:protocol => "ipProtocol", :fromport => "fromPort", :toport => "toPort", :source => "ipRanges/item/cidrIp"})
  end

  #def describesnapshots
  #  q = createSign(@parameters, @thezone.entrypoint)
  #  r = queryCloud(q, @thezone.entrypoint)
  #  parseQuery("instancesSet/item/instanceId",r)
  #end

  def describevolumes
    if not checkRequirements(["thezone"])
       resturn false
    end
    @parameters['Action']="DescribeVolumes"
  #  @parameters['VolumeId.1']=@volume.serial
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    getResources('//volumeSet/item',r,{:id => "volumeId", :size => "size", :availability => "availabilityZone"})
  end

  def detachvolume
    if not checkRequirements(["thezone","thevolume"])
       return false
    end
    @parameters['Action']="DetachVolume"
    @parameters['VolumeId']=@thevolume.serial
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("status",r)
  end

  def disassociateaddress
    if not checkRequirements(["thezone","theips"])
       return false
    end
    @parameters['Action']="DisassociateAddress"
    @parameters['PublicIp']=@theips.name
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("return",r)
  end

  def importkeypair
    if not checkRequirements(["thezone","thekey"])
       return false
    end
    @parameters['Action']="ImportKeyPair"
    @parameters['KeyName']=@theykey.name
    @parameters['PublicKeyMaterial']=@thekey.public
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("keyName",r)
  end

  def rebootinstances
    if not checkRequirements(["thezone","theserver"])
       return false
    end
    @parameters['Action']="RebootInstances"
    @parameters['InstanceId.1']=@theserver.serial
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("return",r)
  end

  #def registerimage
  #
  #  q = createSign(@parameters, @thezone.entrypoint)
  #  r = queryCloud(q, @thezone.entrypoint)
  #  parseQuery("instancesSet/item/instanceId",r)
  #end

  def releaseaddress
    if not checkRequirements(["thezone","theips"])
       return false
    end
    @parameters['Action']="ReleaseAddress"
    @parameters['PublicIp']=@theips.name
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("return",r)
  end

  def revokesecuritygroupingress
    if not checkRequirements(["thezone","thefirewall","therule"])
       return false
    end
    @parameters['Action']="RevokeSecurityGroupIngress"
    @parameters['GroupId']=@thefirewall.serial
    @parameters['IpProtocol']=@therule.protocol.downcase
    @parameters['FromPort']=@therule.fromport
    @parameters['ToPort']=@therule.toport
    @parameters['CidrIp']=@therule.source
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("return",r)
  end

  def runinstances
    if not checkRequirements(["thezone","theimage","thefirewall","theoffer"])
       return false
    end
    @parameters['Action']="RunInstances"
    @parameters['ImageId']=@theimage.serial
    @parameters['MinCount']=1
    @parameters['MaxCount']=1
#    @parameters['KeyName']=@thekey.name
    @parameters['SecurityGroupId.1']=@thefirewall.serial
    @parameters['InstanceType']=@theoffer.code
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("instancesSet/item/instanceId",r)
  end

  def startinstances
    if not checkRequirements(["thezone","theserver"])
       return false
    end
    @parameters['Action']="StartInstances"
    @parameters['InstanceId.1']=@theserver.serial
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("instancesSet/item/currentState/code",r)
  end

  def stopinstances
    if not checkRequirements(["thezone","theserver"])
       return false
    end
    @parameters['Action']="StopInstances"
    @parameters['InstanceId.1']=@theserver.serial
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("instancesSet/item/currentState/code",r)
  end

  def terminateinstances
    if not checkRequirements(["thezone","theserver"])
       return false
    end
    @parameters['Action']="TerminateInstances"
    @parameters['InstanceId.1']=@theserver.serial
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("instancesSet/item/currentState/code",r)
  end


########################################LOAD BALANCER SECTION

  def createloadbalancer
    if not checkRequirements(["thezone","theloadbalancer"])
      return false
    end
    @parameters['Action']="CreateLoadBalancer"
    @parameters['LoadBalancerName']=@theloadbalancer.serial
    @parameters['AvailabilityZones.member.1']=@theloadbalancer.subzone
    @parameters['Listeners.member.1.InstancePort']=@theloadbalancer.serverport
#    @parameters['Listeners.member.1.InstanceProtocol']=@theloadbalancer.protocol
    @parameters['Listeners.member.1.LoadBalancerPort']=@theloadbalancer.port
    @parameters['Listeners.member.1.Protocol']=@theloadbalancer.protocol
    @parameters['Version']='2011-11-15'
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    #parseQuery("DNS",r)
  end

  def configurehealthcheck
    if not checkRequirements(["thezone","theloadbalacner","thehcheck"])
      return false
    end
    @parameters['Action']="ConfigureHealthCheck"
    @parameters['LoadBalancerName']=@theloadbalancer.serial
    @parameters['HealthCheck.HealthyThreshold']=@thehcheck.healthy
    @parameters['HealthCheck.Interval']=@thehcheck.interval
    @parameters['HealthCheck.Target']=@thehcheck.target
    @parameters['HealthCheck.Timeout']=@thehcheck.timeout
    @parameters['HealthCheck.UnhealthyThreshold']=@thehcheck.unhealthy
    @parameters['Version']='2011-11-15'
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    return r
    # parseQuery("",r)
  end
   
  def createloadbalancerlistener
    if not checkRequirements(["thezone","theloadbalancer"])
      return false
    end
    @parameters['Action']="CreateLoadBalancerListeners"
    @parameters['LoadBalancerName']=@theloadbalancer.serial
    @parameters['Listeners.member.1.InstancePort']=@theloadbalancer.serverport
#    @parameters['Listeners.member.1.InstanceProtocol']=@theloadbalancer.protocol
    @parameters['Listeners.member.1.LoadBalancerPort']=@theloadbalancer.port
    @parameters['Listeners.member.1.Protocol']=@theloadbalancer.protocol
    @parameters['Version']='2011-11-15'
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    #parseQuery("DNS",r)
  end

  def deleteloadbalancer
    if not checkRequirements(["thezone","theloadbalancer"])
      return false
    end
    @parameters['Action']="DeleteLoadBalancer"
    @parameters['LoadBalancerName']=@theloadbalancer.serial
    @parameters['Version']='2011-11-15'
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    #parseQuery("DNS",r)
  end

  def deleteloadbalancerlistener
    if not checkRequirements(["thezone","theloadbalancer"])
      return false
    end
    @parameters['Action']="DeleteLoadBalancerListeners"
    @parameters['LoadBalancerName']=@theloadbalancer.serial
    @parameters['LoadBalancerPorts.member.1']=@theloadbalancer.serverport
    @parameters['Version']='2011-11-15'
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    #parseQuery("DNS",r)
  end
  
  def describeloadbalancers
    
  end

  def enableavailabilityzone
    if not checkRequirements(["thezone","theloadbalancer"])
      return false
    end
    @parameters['Action']="EnableAvailabilityZonesForLoadBalancer"
    @parameters['LoadBalancerName']=@theloadbalancer.serial
    @parameters['AvailabilityZones.member.1']=@theloadbalancer.subzone
    @parameters['Version']='2011-11-15'
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    #parseQuery("DNS",r)
  end

  def disableavailabilityzone
    if not checkRequirements(["thezone","theloadbalancer"])
      return false
    end
    @parameters['Action']="DisableAvailabilityZonesForLoadBalancer"
    @parameters['LoadBalancerName']=@theloadbalancer.serial
    @parameters['AvailabilityZones.member.1']=@theloadbalancer.subzone
    @parameters['Version']='2011-11-15'
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    #parseQuery("DNS",r)
  end

  def registerserverwithlb
    if not checkRequirements(["thezone","theloadbalancer","theserver"])
      return false
    end
    @parameters['Action']="RegisterInstancesWithLoadBalancer"
    @parameters['LoadBalancerName']=@theloadbalancer.serial
    @parameters['Instances.member.1']=@theserver.serial
    @parameters['Version']='2011-11-15'
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    #parseQuery("DNS",r)

  end

    def deregisterserverwithlb
    if not checkRequirements(["thezone","theloadbalancer","theserver"])
      return false
    end
    @parameters['Action']="DeregisterInstancesWithLoadBalancer"
    @parameters['LoadBalancerName']=@theloadbalancer.serial
    @parameters['Instances.member.1']=@theserver.serial
    @parameters['Version']='2011-11-15'
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    #parseQuery("DNS",r)

  end

#############################################################

  def resetParams
    @parameters = {
       'AWSAccessKeyId'       => @key,
       'SignatureMethod'      => 'HmacSHA256',
       'SignatureVersion'     => 2,
       'Version'              => '2011-12-15'
    }
  end

  def checkRequirements(args)
    varmis = true
    args.each do |var|
      eval "if not @#{var}
            varmis = false
          end"
    end
    resetParams
    return varmis
  end

  def createSign(parameters, location)
    parameters['Timestamp'] = Time.now.iso8601
    canonical_querystring = parameters.sort.collect { |key, value| [URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")), URI.escape(value.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))].join('=') }.join('&')
    string_to_sign = "GET
#{location}
/
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
      sock.use_ssl = true
      path = "/?#{querys}"
      resp = sock.get(path)
      resp.body
	    rescue Errno::EHOSTUNREACH
      false
    end
  end

  def parseQuery(path, r)
    if r
      doc = REXML::Document.new(r)
      if doc.root.elements["Errors"]
        return false
      end
      doc.root.elements[path].text
    else
      false
    end
  end

  def getResources(path, resp, resor)
    if resp
      doc = REXML::Document.new(resp)
      if doc.root.elements["Errors"]
         return false
      end
      a = Array.new
      REXML::XPath.each(doc,path) do |d|
        h = Hash.new
        resor.each do |k,v|
          t = d.elements[v]
          h[k] = t.text if t
        end
        a << h
      end
      a
    else
      false
    end
  end

end
