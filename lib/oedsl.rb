module Oedsl  

  class InfraDSL
    @@acct = 0
    @@iid = 0
    def initialize(id, iid)
      @@acct = id
      @@iid = iid
    end
    def self.build(&block)
      instance_eval(&block)
    end
    def self.zone(name,&block)
      ZoneDSL.new(name, @@acct, @@iid, &block)
    end
    def method_missing(m, *args, &block)
      puts "This is not valid #{m}"
    end
  end

  class ZoneDSL
    def initialize(name, acct, infraid, &block)
      @zid = Account.find(acct).zones.find_by_name(name).id
      @aid = acct
      @infraid = infraid
      if not @zid
        raise "Zone doesn't exist"
      end
      instance_eval(&block)
    end
    def subzone(name,&block)
      SubzoneDSL.new(name, @zid, @aid, @infraid, &block)
    end
    def method_missing(m, *args, &block)
      puts "ups it doesnt exist zonedsl #{m}"
    end
  end

  class SubzoneDSL
    def initialize(name, zid, aid, infraid, &block)
      @szid = Zone.find(zid).azones.find_by_name(name).id
      @infraid = infraid
      if not @szid
        raise "Subzone doesn't exist"
      end
      @zid = zid
      @aid = aid
      instance_eval(&block)
    end
    def keypair(name,&block)
      KeypairDSL.new(name, @zid, @szid, @aid, @infraid, &block)
    end
    def firewall(name, &block)
      FirewallDSL.new(name, @zid, @szid, @aid, @infraid, &block)
    end
    def volume(name, &block)
      VolumeDSL.new(name, @zid, @szid, @aid, @infraid, &block)
    end
    def server(name, &block)
      ServerDSL.new(name, @zid, @szid, @aid, @infraid, &block)
    end
    def groupvolume(name, &block)
      GroupVolumeDSL.new(name, @zid, @szid, @aid, @infraid, &block)
    end
    def method_missing(m, *args, &block)
      puts "ups it doesnt exist subzonedsl #{m}"
    end
  end

  class KeypairDSL
    def initialize(name, zid, szid, aid, infraid, &block)
      instance_eval(&block)
      k = Keypair.create(:name => "keypair-#{name}", :zone_id => zid, :azone_id => szid, :public => @pubk, :private => @prik, :infrastructure_id => infraid )
      #k.send_create if k
      k.account_id = aid
      k.save
    end
    def publickey(pubk)
      @pubk = pubk
    end
    def privatekey(prik)
      @prik = prik
    end
    def method_missing(m, *args, &block)
      puts "ups it doesnt exist keypairdsl #{m}"
    end
  end

  class GroupVolumeDSL
    def initialize(name, zid, szid, aid, infraid, &block)
      instance_eval(&block)
      @vcount.times do |n|
        v = Volume.create(:serial => nil, :name => "volume-#{name}", :description => "#{name}-group", :zone_id => zid, :azone_id => szid, :server_id => nil, :infrastructure_id => infraid )
        #v.send_create if v
	v.account_id = aid
	v.save
      end
    end
    def size(vsize)
      @vsize = vsize
    end
    def count(vcount)
      @vcount = vcount
    end
    def method_missing(m, *args, &block)
      puts "ups it doesnt exist groupvolumedsl #{m}"
    end
  end

  class VolumeDSL
    def initialize(name, zid, szid, aid, infraid, &block)
      instance_eval(&block)
      v = Volume.create(:serial => nil, :name => "volume-#{name}", :description => "#{name}", :size => @vsize, :zone_id => zid, :azone_id => szid, :server_id => nil, :infrastructure_id => infraid )
      #v.send_create
	v.account_id = aid
	v.save
    end
    def size(vsize)
       @vsize = vsize
    end
    def method_missing(m, *args, &block)
      puts "ups it doesnt exist volumedsl #{m}"
    end
  end

  class FirewallDSL
    def initialize(name, zid, szid, aid, infraid, &block)
      @zid = zid
      @aid = aid
      @infraid = infraid
      @f = Firewall.create(:name => "firwall-#{name}", :description => "#{name}", :zone_id => zid, :azone_id => szid, :infrastructure_id => infraid )
	@f.account_id = aid
	@f.save
      #f.send_create if f
      instance_eval(&block)
    end
    def rule(&block)
      RuleDSL.new(@f.id, @zid, @szid, @aid, @infraid, &block)
    end
    def method_missing(m, *args, &block)
      puts "ups it doesnt exist firewalldsl #{m}"
    end
  end

  class RuleDSL
    def initialize(fid, zid, szid, aid, infraid, &block)
      instance_eval(&block)
      if not @fsource then raise "Error missing source on firewall definition" end
      if not @fsport then raise "Error missing source port on firewall definition" end
      if not @fdport then raise "Error missing destination port on firewall definition" end
      if not @fproto then raise "Error missing protocol on firewall definition" end
      r = Rule.create(:firewall_id => fid, :fromport => @fsport, :toport => @fdport, :source => @fsource, :protocol => @fproto, :infrastructure_id => infraid )
      r.account_id = aid
      r.save
      #r.send_create if r
    end
    def source(src)
      @fsource = src
    end
    def sport(sport)
      @fsport = sport
    end
    def dport(dport)
      @fdport = dport
    end
    def protocol(proto)
      @fproto = proto.upcase
    end
    def method_missing(m, *args, &block)
      puts "missing on rule ruledsl #{m}"
    end
  end

  class ServerDSL
    def initialize(prefix, zid, szid, aid, infraid, &block)
      @aid = aid
      @serv = {}
      instance_eval(&block)
      if not @serv[:firewall_id] then raise "Error missing firewall on server definition" end
      if not @serv[:offer_id] then raise "Error missing offer on server definition" end
      if not @serv[:image_id] then raise "Error missing image on server definition" end
      if not @serv[:keypair_id] then raise "Error missing keypair on server definition" end
      if @count.nil?
        @count = 1 
      end
      @serv[:zone_id] = zid
      @serv[:azone_id] = szid
      @serv[:infrastructure_id] = infraid
      @count.times do |n|
	@serv[:name] = "#{prefix}-#{n}"
	@serv[:fqdn] = "#{prefix}-#{n}"
        #s = Server.create(:fqdn => "#{prefix}-#{n}", :zone_id => zid, :azone_id => szid, :offer_id => @soffer, :image_id => @simage, :firewall_id => @sfirewall, :keypair_id => @skeypair, :account_id => aid, :role_id => @srole, :deployment_id => @sdeploy, :infraestructure_id => infraid )
        s = Server.create(@serv )
        s.account_id = aid
        s.save
      end
    end
    def image(img)
      if not Image.where("serial = ? and account_id = ?", img, @aid ).first
         raise "Image doesn't exist"
      end
      @serv[:image_id] = Image.where("serial = ? and account_id = ?", img, @aid ).first.id
    end
    def offer(off)
      if not Offer.where("code = ? and account_id = ?", off, @aid ).first
         raise "Offer doesn't exist"
      end
      @serv[:offer_id] = Offer.where("code = ? and account_id = ?", off, @aid ).first.id
    end
    def firewall(fw)
      if not Firewall.where("name = ? and account_id = ?", fw, @aid ).first 
        raise "Firewall doesn't exist under this zone/subzone...  please remove the firewall setting or create it"
      end
      @serv[:firewall_id] = Firewall.where("name = ? and account_id = ?", fw, @aid ).first.id
    end
    def role(r)
      if not Role.where("serial = ? and account_id = ?", r, @aid ).first
        raise "Role doesn't exist..."
      end
      @serv[:role_id] = Role.where("serial = ? and account_id = ?", r, @aid).first.id
    end
    def deployment(d)
      if not Deployment.where("serial = ? and account_id = ?", d, @aid)
        raise "Deployment doesn't exist..."
      end
      @serv[:deployment_id] = Deployment.where("serial = ? and account_id = ?", d, @aid).first
    end
    def keypair(k)
      if not Keypair.where("name = ? and account_id = ?", k, @aid).first 
          raise "Keypair doesn't exist"
      end
      @serv[:keypair_id] = Keypair.where("name = ? and account_id = ?", k, @aid).first.id
    end
#    def groupvolume(gname, device)
#      @gname = gname
#      @device = device
#    end
    def volume(v)
      if not Volume.where("name = ? and account_id = ?", v, @aid).first
         raise "Volume doesnt exist"
      end
      @serv[:volume_id] = Volume.where("name = ? and account_id = ?", v, @aid).first.id
    end
    def count(c)
      @count = c
    end
#    def escalar(e)
#      @sescalar = e
#    end
    def method_missing(m, *args, &block)
      puts "missing on server serverdsl #{m}"
    end
  end

end
