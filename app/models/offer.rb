class Offer < ActiveRecord::Base
        belongs_to :zone
	belongs_to :account
        has_many :servers
	attr_accessible :code, :description
        validates :code, :presence => true
        validates :zone_id, :presence => true
end
