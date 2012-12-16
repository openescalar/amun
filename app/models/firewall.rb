class Firewall < ActiveRecord::Base
	include Oedist
        belongs_to :zone
        belongs_to :azone
	belongs_to :account
        has_many :rules, :dependent => :destroy
        has_many :servers
        attr_accessible :infrastructure_id, :name, :description, :server_ids, :rule_ids, :zone_id, :azone_id
        validates :zone_id, :presence => true

##### Message format
# yaml
# action | object | id | account_id
#
#
  def send_create
    msg = {:action => "create", :object => "firewall", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg(msg)
  end
 
  def send_update
    msg = {:action => "update", :object => "firewall", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg(msg)
  end

  def send_delete
    msg = {:action => "delete", :object => "firewall", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg(msg)
  end

end
