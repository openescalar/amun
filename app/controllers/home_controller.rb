class HomeController < ApplicationController
  def index
  end

  def login
    if request.post?
      user = User.authenticate(params[:username], params[:password])
      if user
        session[:user_id] = user.id
	if not user.username == "admin"
       	  session[:user_account] = user.accounts[0].id
        end
        redirect_to(:action => 'index')
	return
      else
        flash.now[:notice] = "Invalid username/password"
      end
    else
      if session[:user_id]
        redirect_to(:action => 'index')
	return
      end
    end
    render :layout => 'login'
  end

  def logout
     session[:user_id] = nil
     flash.keep(:notice)
     flash[:notice] = "Logged Out " + flash[:notice] if flash[:notice] != nil
     redirect_to(:action => "login")
  end

  def forgotpassword
    if request.post?
      user = User.find_by_username(params[:username])
      if user
        if user.email == params[:email]
          begin 
            UserMailer.reset_password(user).deliver
          rescue => e
            logger.debug e.inspect.to_s
          end
          flash[:notice] = "Reset Password Sent"
        else 
          flash[:notice] = "Email does not match Users email"
        end
       else
        flash[:notice] = "User does not exist"
       end 
      redirect_to(:action => "login")
    else
      if session[:user_id]
        redirect_to(:action => 'index')
	      return
      else
        render :layout => 'login'
      end
    end
  end

  def signup
    if request.post?
      account = Account.find_by_name(params[:name].to_s)
      user = User.find_by_username(params[:name].to_s)
      eaccount = Account.find_by_email(params[:email].to_s)
      if not account and not user and not eaccount
        Account.create(:name => params[:name].to_s, :email => params[:email].to_s)
        flash[:notice] = 'Account created'
        redirect_to(:action => "login")
      else
        flash[:notice] = "Username is already in use"
        redirect_to(:action => "signup")
      end
    else
      render :layout => 'login'
    end
  end
  
end
