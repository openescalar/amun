class Role < ActiveRecord::Base
	belongs_to :account
        has_and_belongs_to_many :servers
	has_many :roletasks
        attr_accessible :name, :description, :metadata, :roletask_ids
        validates :name, :presence => true, :uniqueness => true
	#after_create :plusdefaulttasks
        before_create :genSerial

protected
  def genSerial
    self.serial = "r-" + (0..5).map{ (0..9).to_a[rand(4)] }.join.to_s
  end
  
  def plusdefaulttasks
    %w[build destroy].each do |action|
       self.roletasks.create(:name => action, :content => "put your #{action} code here", :account_id => account_id)
    end
  end
end
