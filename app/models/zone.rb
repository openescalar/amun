class Zone < ActiveRecord::Base
	include Oedist
        has_many :images
        has_many :offers
        has_many :servers
        has_many :volumes
        has_many :firewalls
        has_many :loadbalancers
        has_many :distros
	has_many :azones, :dependent => :destroy
        has_many :keypairs
        #has_and_belongs_to_many :keypairs
        belongs_to :account
	attr_accessible :name, :description, :entrypoint, :apitype, :key, :secret, :tenant, :account_id
	validates :key, :presence => true
	validates :secret, :presence => true
        validates :name, :presence => true, :uniqueness => true
        validates :entrypoint, :presence => true, :uniqueness => true
        validates :apitype, :presence => true, :inclusion => { :in => ["AWS","RS","RSOPEN","EUCA","OSNOVA","HPOS","TEST"] }
        after_create :addavailablezone

  def send_import
    if not self.imported
      msg = {:action => "import", :object => "zone", :objectid => self.id, :account_id => self.account_id }.to_yaml
      sendMsg(msg)
    end
  end

protected
  def addavailablezone
    if self.apitype == "EUCA"
      c = Oecloud.new(:zone => self, :key => self.key, :secret => self.secret)
      z = c.importavailablezones
      if z
        case z.class.to_s
          when "Array"
    	    z.each do |az|
              self.azones.create(:name => az)
            end 
          when "Hash"
            z.each_key do |az|
              self.azones.create(:name => az, :endpoint => z[az])
            end
        end
      end
    elsif self.apitype == "TEST"
      self.azones.create(:name => "aztest", :endpoint => "test.test.com")
    end
  end
end
