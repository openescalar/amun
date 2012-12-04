module Cobapi

###################Import functions ##################

  def importimages
  end

  def importservers
  end

  def importvolumes
  end

  def importfirewalls
  end

  def importlb
  end


####################Server functions#######

  def allocateaddress
  end

  def associateaddress
  end

  def authorizedsecuritygroupingress
  end

  def createimage
  end

  def createkeypair
  end

  def createsecuritygroup
  end

  def createsnapshot
  end

  def createvolume
  end

  def deletekeypair
  end

  def deletesecuritygroup
  end

  def deletesnapshot
  end

  def deletevolume
  end

  def deregisterimage
  end

  def describeaddresses
  end

  def describeimages
  end

  def describeinstances
  end

  def describekeypairs
  end

  def describesecuritygroups
  end

  def describesnapshots
  end

  def describevolumes
  end

  def detachvolume
  end

  def disassociateaddress
  end

  def importkeypair
  end

  def rebootinstances
  end

  def registerimage
  end

  def releaseaddress
  end

  def revokesecuritygroupingress
  end

  def runinstances
  end

  def startinstances
  end

  def stopinstances
  end

  def terminateinstances
  end
################################LOAD BALANCER SECTION

  def createloadbalancer
  end

  def configurehealthcheck
  end

  def createloadbalancerlistener
  end

  def deleteloadbalancer
  end

  def deleteloadbalancerlistener
  end

  def descbribeloadbalancer
  end

  def enableavailabilityzone
  end

  def disableavailabilityzone
  end

  def registerserverwithlb
  end

  def deregisterserverwithlb
  end



  def createCobblerServer(stemplateid, skelcode, locationid, sfqdn = nil )
    handle = @cobbler.call("new_system", @token)
    @cobbler.call("modify_system", handle, "name", serverid, @token)
    @cobbler.call("modify_system", handle, "profile", stemplateid, @token)
    if sfqdn
      @cobbler.call("modify_system", handle, "hostname", sfqdn, @token)
    end
    @cobbler.call("save_system", handle, @token)
  end
  def statusCobblerServer(serverid, locationid)
    return false
  end
  def destroyCobblerServer(serverid, locationid)
    @cobbler.call("remove_system", serverid, @token)
  end
  def rebootCobblerServer(serverid, locationid)
    return false
  end
  def startCobblerServer(serverid, locationid)
    return false
  end
  def stopCobblerServer(serverid, locationid)
    return false
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


end
