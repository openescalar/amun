class Distro < ActiveRecord::Base
        belongs_to :zone
	belongs_to :account
        validates :serial, :presence => true
        validates :arch, :presence => true, :inclusion => { :in => ["x86_64","i686"] }
        validates :zone_id, :presence => true
end
