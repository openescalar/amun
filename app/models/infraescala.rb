class Infraescala < ActiveRecord::Base
	belongs_to :infraestructure
	has_many   :servers
	has_many :votes, :dependent => :destroy
end
