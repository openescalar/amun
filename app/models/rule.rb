class Rule < ActiveRecord::Base
        include Oedist
        belongs_to :firewall
	belongs_to :account
	attr_accessible :infrastructure_id, :protocol, :fromport, :toport, :source, :firewall_id
        validates :protocol, :presence => true, :inclusion => { :in => ["TCP","UDP","ICMP","tcp","udp","icmp"] }
        validates :fromport, :presence => true
        validates :toport, :presence => true
        validates :source, :presence => true
        validates :firewall_id, :presence => true
#        after_create :send_create

  def send_create
    msg = { :action => "create", :object => "rule", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg msg
  end
  
  def send_update
    msg = { :action => "update", :object => "rule", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg msg
  end

  def send_delete
    msg = { :action => "delete", :object => "rule", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg msg
  end

end
