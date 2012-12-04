class User < ActiveRecord::Base
	has_and_belongs_to_many :accounts
	validates :name, :presence => true
	validates :username, :presence => true, :uniqueness => true
	validates :password, :presence => true
	validates :email, :presence => true
        validates_confirmation_of :password
        validate :password_non_blank
        validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Email must be valid"
        attr_accessible :username, :password, :email, :name
	before_create :encrypt_password
        before_update :encrypt_password2

        def self.authenticate(username, passwd)
                user = self.find_by_username(username)
                if user
                        expected_password = encrypted_password(passwd, user.name)
                        if user.password != expected_password
                                user = nil
                        end
                end
                user
        end
        def checkpass(passwd)
                        expected_password = rencrypt_password(passwd, name)
                        if password != expected_password
                           false 
                        else
                           true
                        end

        end

private
        def password_non_blank
                  errors.add(:password, "Missing password") if password.blank?
        end

	def encrypt_password
		string_to_hash = password + "oescalar" + name
		self.password = Digest::SHA1.hexdigest(string_to_hash)
	end

        def rencrypt_password(passwd, name)
		string_to_hash = passwd + "oescalar" + name
		Digest::SHA1.hexdigest(string_to_hash)
        end

        def self.encrypted_password(passwd, name)
                string_to_hash = passwd + "oescalar" + name
                Digest::SHA1.hexdigest(string_to_hash)
        end

        def encrypt_password2
              u = User.find(self.id)
              if self.password != u.password
                string_to_hash = password + "oescalar" + name
                expect_pass = Digest::SHA1.hexdigest(string_to_hash)
                if expect_pass != u.password
                   self.password = expect_pass
                else
                   self.password = u.password
                end
              end
        end


end

