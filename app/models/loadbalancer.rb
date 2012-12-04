class Loadbalancer < ActiveRecord::Base
        include Oedist
        belongs_to :zone
        belongs_to :azone
	belongs_to :account
        has_many :servers
        validates :port, :presence => true, :numericality => true
        validates :zone_id, :presence => true
#        validates_each :serial do |model, attr, value|
#          if not value
#            model.errors.add(attr, " - Error from cloud, could not provide resource")
#            model.serial = ""
#          end
#        end
#        after_create :send_create

  def send_create
    msg = { :action => "create", :object => "loadbalancer", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg msg
  end

  def send_update
    msg = { :action => "update", :object => "loadbalancer", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg msg
  end

  def send_delete
    msg = { :action => "delete", :object => "loadbalancer", :objectid => self.id, :accountid => self.account_id }.to_yaml
    sendMsg msg
  end

end
