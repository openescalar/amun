class Keypair < ActiveRecord::Base
  include Oedist
  belongs_to :account
  belongs_to :zone
  belongs_to :azone
  has_many :servers
  #has_and_belongs_to_many :zones
  attr_accessible :zone_id, :azone_id, :name, :public, :private, :fingerprint
  validates :name, :presence => true, :uniqueness => true
  def send_create
    msg = { :action => "create", :object => "keypair", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg msg
  end

  def send_update
    msg = { :action => "update", :object => "keypair", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg msg
  end

  def send_delete
    msg = { :action => "delete", :object => "keypair", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg msg
  end


end
