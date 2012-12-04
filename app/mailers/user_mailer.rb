class UserMailer < ActionMailer::Base
  require 'securerandom'

  default from: "openescalar@openescalar.org"

  def welcome_email(user, url)
    @user = user
    @url = url
    mail(:to => user.email, :subject => "Welcome to OpenEscalar")
  end

  def invite_email(user,account,sponsor)
    @user = user
    @sponsor = sponsor
    @acc = account
    mail(:to => user.email, :subject => "OpenEscalar Invitation to join an account")
  end

  def reset_password(user, url)
    @user = user
    @pass = SecureRandom.hex
    @user.password = @pass
    @user.save
    @url = url
    mail(:to => user.email, :subject => "OpenEscalar Password Reset")
  end
end
