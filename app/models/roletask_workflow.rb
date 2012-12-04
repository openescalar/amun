class RoletaskWorkflow < ActiveRecord::Base
  belongs_to :workflow
  belongs_to :roletask
end
