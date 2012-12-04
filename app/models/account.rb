class Account < ActiveRecord::Base
        require 'openssl'
        require 'base64'
	has_and_belongs_to_many :users
	has_many :servers
	has_many :zones
	has_many :images
	has_many :firewalls
	has_many :loadbalancers
	has_many :offers
	has_many :distros
	has_many :volumes
	has_many :rules
	has_many :roles
	has_many :roletasks
	has_many :deployments
	has_many :infrastructures
	has_many :workflows
        has_many :keypairs
        has_many :events
        attr_accessible :name, :email
	before_create :genkeysecret
	before_create :create_a_user
	after_create :add_a_user
	validates :name, :presence => true, :uniqueness => true
	validates :email, :presence => true

protected
  def genkeysecret
    if name != "admin"
      self.key = Base64.encode64("#{OpenSSL::HMAC.digest('sha1', name, Time.now.to_s)}").chomp
      self.secret = Base64.encode64("#{OpenSSL::HMAC.digest('sha1', email, Time.now.to_s)}").chomp
    end
  end
  def create_a_user
	if not User.create(:username => name, :name => name + "_account", :email => email, :password => email) 
		false
	else 
	  UserMailer.welcome_email(User.find_by_username(name)).deliver
	end
  end
  def add_a_user
	users << User.find_by_username(name)
  end
end
