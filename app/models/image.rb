class Image < ActiveRecord::Base
        belongs_to :zone
        belongs_to :azone
	belongs_to :account
        has_many :servers
        attr_accessible :serial, :description, :arch
        validates :serial, :presence => true
        validates :arch, :presence => true, :inclusion => { :in => ["x86_64","i686"] }
        validates :zone_id, :presence => true
        extend Oedist
end
