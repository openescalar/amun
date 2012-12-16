class Infrastructure < ActiveRecord::Base
        include Oedist
	require 'securerandom'
        has_many :volumes
        has_many :rules
        has_many :servers
        has_many :keypairs
        has_many :loadbalancers
        has_many :firewalls
	has_many :infraescalas
	belongs_to :account
        attr_accessible :name, :description, :definition
        before_save :parseinfra
        #after_create :send_create ---> We're commenting this one since it should run during build not during create
	before_create :genSerial

  def send_create
    msg = { :action => "create", :object => "infrastructure", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg msg
  end

  def send_update
    msg = { :action => "update", :object => "infrastructure", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg msg
  end

  def send_delete
    msg = { :action => "delete", :object => "infrastructure", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg msg
  end  

  def build
    begin
      #self.transaction do 
	instance_eval("Oedsl::InfraDSL.new(#{self.account_id}, #{self.id})\r\n Oedsl::InfraDSL.build do " + self.definition + " end ")    
        #instance_eval("Oedsl::InfraDSL.new(#{self.account_id}, #{self.id})\r\n Oedsl::InfraDSL." + self.definition)
        #uuid = SecureRandom.uuid
        #Event.create(:otype => "infrastructure", :ntype => self.serial, :status => "building", :description => self.name, :account => self.account_id, :user => self.account.name , :ident => uuid, :server => nil)
    #  end
    #    self.send_create
      false
    rescue RuntimeError => e
      "Error in definition..." + e.to_s
    end
  end

protected
  def parseinfra
    begin
      Oecompiler::Compiler.new(self.definition).checkGrammar   
      true
    rescue RuntimeError => fix
      self.errors.add(:definition, " - Error in definition ... #{fix.to_s} ... please see definition example")
      false
    end
  end

  def genSerial
    self.serial = "infra-" + (0..5).map{ (0..9).to_a[rand(4)] }.join.to_s
  end

end
