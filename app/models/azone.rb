class Azone < ActiveRecord::Base
  belongs_to :zone
  attr_accessible :name, :status, :endpoint
end
