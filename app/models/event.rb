class Event < ActiveRecord::Base
  belongs_to :account
  belongs_to :server
  serialize :child
  validates :status, :account, :user, :ident, :presence => true
end
