class Volume < ActiveRecord::Base
        include Oedist
        belongs_to :zone
        belongs_to :azone
        belongs_to :server
	belongs_to :account
        belongs_to :infrastructure
        validates :size, :presence => true
        validates :zone_id, :presence => true
        validates :azone_id, :presence => true
        validates :name, :presence => true
	attr_accessible :infrastructure_id, :description, :device, :name, :size, :zone_id, :azone_id, :server_id

  def send_create
    msg = { :action => "create", :object => "volume", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg msg
  end

  def send_update
    msg = { :action => "update", :object => "volume", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg msg
  end

  def send_delete
    msg = { :action => "delete", :object => "volume", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg msg
  end

  def send_attach
    msg = { :action => "attach", :object => "volume", :objectid => self.id, :accountid => self.account_id, :serverid => self.server.id }.to_yaml
    sendMsg msg
  end

  def send_detach
    msg = { :action => "detach", :object => "volume", :objectid => self.id, :accountid => self.account_id, :serverid => self.server.id }.to_yaml
    sendMsg msg
  end

end
