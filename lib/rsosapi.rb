module Rsosapi
#  require 'osapi'
  include Osapi

  def associateaddress
   if not checkRequirements(["thezone","theserver","theip"])
      return false
    end
    checkToken(@thezone)
    req = JSON '{"addFloatingIp":{"server":"' + @theserver.serial + '", "address":"' + @theip.address + '"}}'
    data = queryOS(:component => "Nova", :entrypoint => @theserver.azone.entrypoint, :request => req.to_json, :method => "post", :path => "#{@thezone.tenant}/servers/" + @theserver.serial + "/action", :token => @thezone.token )
    data ? data : false
  end

  def createkeypair
    if not checkRequirements(["thezone", "thekey"])
       return false
    end
    @thekey.private
  end

  def deletekeypair
    false
  end

  def authorizedsecuritygroupingress
    true
  end

  def revokesecuritygroupingress
    true
  end

  def createsecuritygroup
    SecureRandom.uuid
  end
 
  def deletesecuritygroup
    true
  end

  def createvolume
    if not checkRequirements(["thezone","thevolume"])
      return false
    end
    checkToken(@thezone)
    req = JSON '{"volume":{"display_name":"' + @thevolume.name + '", "display_description":"' + @thevolume.description + '", "size":"' + @thevolume.size.to_s + '", "availability_zone":"' + @thevolume.azone.name + '"}}'
    data = queryOS(:component => "Nova", :entrypoint => @thevolume.azone.endpoint, :request => req.to_json, :method => "post", :path => "#{@thezone.tenant}/os-volumes", :token => @thezone.token )
    data ? data["volume"]["id"] : false
  end

  def deletevolume
    if not checkRequirements(["thezone","thevolume"])
      return false
    end
    checkToken(@thezone)
    data = queryOS(:component => "Nova", :entrypoint => @thevolume.azone.endpoint, :method => "delete", :path => "#{@thezone.tenant}/os-volumes/" + @thevolume.serial, :token => @thezone.token )
    data ? data : false
  end
  
  def disassociateaddress
   if not checkRequirements(["thezone","theserver","theip"])
      return false
    end
    checkToken(@thezone)
    req = JSON '{"removeFloatingIp":{"server":"' + @theserver.serial + '", "address":"' + @theip.address + '"}}'
    data = queryOS(:component => "Nova", :entrypoint => @theserver.azone.entrypoint, :request => req.to_json, :method => "post", :path => "#{@thezone.tenant}/servers/" + @theserver.serial + "/action", :token => @thezone.token )
    data ? data : false
  end

end
