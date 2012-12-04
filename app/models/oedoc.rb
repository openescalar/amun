class Oedoc
  require 'couchrest'
  def initialize(args)
    if args[:type].to_s == "monitor"
      @cdb = CouchRest.database!("http://dbint.zuncloud.com:5984/watchers")
    else
      @cdb = CouchRest.database!("http://dbint.zuncloud.com:5984/sprofiles")
    end
  end
  def SendDoc(data)
    response = @cdb.save_doc(data)
    return response['id']
  end
  def UpdateDoc(id, data)
    dataold = self.GetDoc(id)
    data["_rev"] = dataold["_rev"]
    data["_id"] = id
    return self.SendDoc(data)
  end
  def GetDoc(id)
    return @cdb.get(id)
  end
  def DestroyDoc(id)
    response = @cdb.get(id)
    dresponse = @cdb.delete_doc({"_id"=>response['_id'],"_rev"=>response['_rev']})
    return dresponse['ok']
  end 


  
end
