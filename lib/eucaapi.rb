module Eucaapi

#######################IMPORT FUNCTIONS

  def importavailablezones
    if not checkRequirements(["thezone"])
       return false
    end
    @parameters['Action']="DescribeAvailabilityZones"
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    h = Hash.from_xml(r)
    a = Array.new
    if h["DescribeAvailabilityZonesResponse"]["availabilityZoneInfo"]["item"].class == Array
      h["DescribeAvailabilityZonesResponse"]["availabilityZoneInfo"]["item"].each do |az|
        a << az["zoneName"]
      end
    else
      a << h["DescribeAvailabilityZonesResponse"]["availabilityZoneInfo"]["item"]["zoneName"]
    end
    return a
  end

  def importimages
    if not checkRequirements(["thezone"])
      return false
    end
    @parameters['Action']="DescribeImages"
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    Hash.from_xml(r)
  end

  def importservers
    if not checkRequirements(["thezone"])
      return false
    end
    @parameters['Action']="DescribeInstances"
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    Hash.from_xml(r)
  end

  def importvolumes
    if not checkRequirements(["thezone"])
      return false
    end
    @parameters['Action']="DescribeVolumes"
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    Hash.from_xml(r)
  end

  def importfirewalls
    if not checkRequirements(["thezone"])
      return false
    end
    @parameters['Action']="DescribeSecurityGroups"
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    Hash.from_xml(r)
  end

  def importlb
    return
  end



### Euca     Functions ###

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
    if not checkRequirements(["thezone","theserver","theip"])
      return false
    end
    @parameters['Action']="AssociateAddress"
    @parameters['InstanceId']=@theserver.serial
    @parameters['PublicIp']=@theip.name
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("return",r)
  end

  def authorizedsecuritygroupingress
    if not checkRequirements(["thezone","therule"])
      return false
    end
    @parameters['Action']="AuthorizeSecurityGroupIngress"
    @parameters['GroupName']=@thefirewall.name
    @parameters['IpProtocol']=@therule.protocol.downcase
    @parameters['FromPort']=@therule.fromport
    @parameters['ToPort']=@therule.toport
    @parameters['CidrIp']=@therule.source
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("return",r)
  end

  def createimage
    false
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
    if parseQuery("return",r)
     return @thefirewall.name
    else
     return false
    end
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
    @parameters['AvailabilityZone']=@thezone.subzone
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
    @parameters['VolumeId']=@thevolume.name
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

  #def describeimages
  #  @parameters['Action']="DescribeImages"
  #  @parameters['ImageId']=@image.serial
  #  q = createSign(@parameters, @thezone.entrypoint)
  #  r = queryCloud(q, @thezone.entrypoint)
  #  parseQuery("instancesSet/item/instanceId",r)
  #end

  def describeinstances(attribute)
    if not checkRequirements(["thezone","theserver"])
      return false
    end
    attributes=""
    case attribute
    when "publicip"
      attributes="ipAddress"
    when "status"
      attributes="instanceState/code"
    when "offer"
      attributes="instanceType"
    when "fqdn"
      attributes="dnsName"
    else
    end
    @parameters['Action']="DescribeInstances"
    @parameters['InstanceId.1']=@theserver.serial
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("reservationSet/item/instancesSet/item/#{attributes}",r)
  end

  #def describekeypairs
  #  @parameters['Action']="DescribeKeyPairs"
  #  @parameters['KeyName.1']=@thekey.name
  #  q = createSign(@parameters, @thezone.entrypoint)
  #  r = queryCloud(q, @thezone.entrypoint)
  #  parseQuery("instancesSet/item/instanceId",r)
  #end

  #def describesecuritygroups
  #  @parameters['Action']="DescribeSecurityGroups"
  #  @parameters['GroupName']=@firewall.name
  #  q = createSign(@parameters, @thezone.entrypoint)
  #  r = queryCloud(q, @thezone.entrypoint)
  #  parseQuery("instancesSet/item/instanceId",r)
  #end

  #def describesnapshots
  #  q = createSign(@parameters, @thezone.entrypoint)
  #  r = queryCloud(q, @thezone.entrypoint)
  #  parseQuery("instancesSet/item/instanceId",r)
  #end

  #def desbribevolumes
  #  @parameters['Action']="DescribeVolume"
  #  @parameters['VolumeId.1']=@thevolume.serial
  #  q = createSign(@parameters, @thezone.entrypoint)
  #  r = queryCloud(q, @thezone.entrypoint)
  #  parseQuery("instancesSet/item/instanceId",r)
  #end

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
    if not checkRequirements(["thezone","theip"])
      return false
    end
    @parameters['Action']="DisassociateAddress"
    @parameters['PublicIp']=@theip.name
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("return",r)
  end

  def importkeypair
    false
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
    if not checkRequirements(["thezone","theip"])
      return false
    end
    @parameters['Action']="ReleaseAddress"
    @parameters['PublicIp']=@theip.name
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("return",r)
  end

  def revokesecuritygroupingress
    if not checkRequirements(["thezone","thefirewall","therule"])
      return false
    end
    @parameters['Action']="RevokeSecurityGroupIngress"
    @parameters['GroupName']=@thefirewall.name
    @parameters['IpProtocol']=@therule.protocol.downcase
    @parameters['FromPort']=@therule.fromport
    @parameters['ToPort']=@therule.toport
    @parameters['CidrIp']=@therule.source
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("return",r)
  end

  def runinstances
    if not checkRequirements(["thezone","theserver","theimage","thefirewall","thekey","theoffer"])
      return false
    end
    @parameters['Action']="RunInstances"
    @parameters['ImageId']=@theimage.serial
    @parameters['MinCount']=1
    @parameters['MaxCount']=1
    @parameters['KeyName']=@thekey.name
    @parameters['SecurityGroup.1']=@thefirewall.serial
    @parameters['InstanceType']=@theoffer.code
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("instancesSet/item/instanceId",r)
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
    @parameters['Action']="TerminateInstances"
    @parameters['InstanceId.1']=@theserver.serial
    q = createSign(@parameters, @thezone.entrypoint)
    r = queryCloud(q, @thezone.entrypoint)
    parseQuery("instancesSet/item/currentState/code",r)
  end

###########################################LOAD BALANCER SECTION

  def createloadbalancer
    false
  end

  def configurehealthcheck
    false
  end

  def createloadbalancerlistener
    false
  end

  def deleteloadbalancer
    false
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
    false
  end

  def deregisterserverwithlb
    false
  end

##############################################


  def checkRequirements(args)
    varmis = true
    args.each do |var|
      eval "if not @#{var}
            varmis = false
          end"
    end
    return varmis
  end


  def createSign(parameters, location)
    parameters['Timestamp'] = Time.now.utc.iso8601
    canonical_querystring = parameters.sort.collect { |key, value| [URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")), URI.escape(value.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))].join('=') }.join('&')
    string_to_sign = "GET
#{location}:8773
/services/Eucalyptus/
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
      sock = Net::HTTP.new(location,8773)
      sock.use_ssl = false
      path = "/services/Eucalyptus/?#{querys}"
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


end
