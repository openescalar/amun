class Workflow < ActiveRecord::Base
  belongs_to :deployment
  belongs_to :account
  has_many :roletask_workflows
  has_many :roletasks, :through => :roletask_workflows
  attr_accessible :name, :description, :metadata
  before_create :genSerial
 
  def flow
    self.roletasks.order("roletask_workflows.id asc")
  end
protected
  def genSerial
    self.serial = "w-" + (0..5).map{ (0..9).to_a[rand(4)] }.join.to_s
  end

end
