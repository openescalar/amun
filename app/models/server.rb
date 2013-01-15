class Server < ActiveRecord::Base
	require 'securerandom'
        include Oedist
        belongs_to :zone
        belongs_to :offer
        belongs_to :image
        belongs_to :loadbalancer
        belongs_to :firewall
        belongs_to :azone
	belongs_to :infraescala
	belongs_to :infrastructure
	belongs_to :keypair
        has_and_belongs_to_many :roles
        has_and_belongs_to_many :deployments
        has_many :volumes
        has_many :events
        belongs_to :account
	attr_accessible :name, :infrastructure_id, :infraescala_id, :fqdn, :zone_id, :azone_id, :keypair_id, :offer_id, :image_id, :firewall_id, :loadbalancer_id, :role_ids, :deployment_ids
        validates :fqdn, :presence => true
        validates :zone_id, :presence => true
        validates :offer_id, :presence => true
        validates :image_id, :presence => true
	validates :keypair_id, :presence => true
        validates :firewall_id, :presence => true
#        validates_each :serial do |model, attr, value|
#          if not value
#            model.errors.add(attr, " - Error from cloud, could not provide resource")
#            model.serial = ""
#          end
#        end
#      	after_create :send_create

  def send_install
    uuid = SecureRandom.uuid
    msg = { :action => "installclient", :object => "server", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg msg
    #Event.create(:status => 4, :account_id => @oeaccount.id, :user => @oeuser.name, :ident => uuid, :description => "Creating Server" )
  end

  def send_create
    uuid = SecureRandom.uuid
    msg = { :action => "create", :object => "server", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg msg
    #Event.create(:status => 4, :account_id => @oeaccount.id, :user => @oeuser.name, :ident => uuid, :description => "Creating Server" )
  end
  
  def send_update
    uuid = SecureRandom.uuid
    msg = { :action => "update", :object => "server", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg msg
    #Event.create(:status => 4, :account_id => @oeaccount.id, :user => @oeuser.name, :ident => uuid, :description => "Updating Server" )
  end
  
  def send_delete
    uuid = SecureRandom.uuid
    msg = { :action => "delete", :object => "server", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg msg
    #Event.create(:status => 4, :account_id => @oeaccount.id, :user => @oeuser.name, :ident => uuid, :description => "Destroying Server" )
  end
  
  def send_get
    uuid = SecureRandom.uuid
    msg = { :action => "get", :object => "server", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg msg
  end

  def getlog
    `tail -25 /opt/openescalar/logging/#{self.serial}/all.log`
  end
  
end
