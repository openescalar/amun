class UserMailer < ActionMailer::Base
  require 'securerandom'

  default from: "openescalar@openescalar.org"

  def welcome_email(user)
    @user = user
    @pass = SecureRandom.hex
    @url = "http://www.openescalar.org"
    mail(:to => user.email, :subject => "Welcome to OpenEscalar")
  end

  def invite_email(user,account,sponsor)
    @user = user
    @sponsor = sponsor
    @acc = account
    mail(:to => user.email, :subject => "OpenEscalar Invitation to join an account")
  end

  def reset_password(user)
    @user = user
    @pass = SecureRandom.hex
    @user.password = @pass
    @user.save
    @url = "http://www.openescalar.org/"
    mail(:to => user.email, :subject => "OpenEscalar Password Reset")
  end
end
