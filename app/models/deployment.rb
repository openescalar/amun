class Deployment < ActiveRecord::Base
        has_and_belongs_to_many :servers
	belongs_to :account
	has_many :workflows, :dependent => :destroy
        attr_accessible :name, :description, :definition, :metadata
        validates :name, :presence => true
        before_create :genSerial
protected
  def genSerial
    self.serial = "d-" + (0..5).map{ (0..9).to_a[rand(4)] }.join.to_s
  end
end
