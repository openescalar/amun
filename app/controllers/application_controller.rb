class ApplicationController < ActionController::Base
  require 'securerandom'
  before_filter :authorize, :except => [ :login, :logout, :forgotpassword, :signup, :gettask, :updatetask ]
  before_filter :setlocale
  protect_from_forgery

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def addtoaccount(thing, value)
        eval "@oeaccount.#{thing} << value"
  end

  def removefromaccount(thing, value)
    eval "if @oeaccount.#{thing}.include? value
             @oeaccount.#{thing}.delete value
          end"
  end

  def checkaccountobject(thing, value)
    if not @oeuser.username == "admin"
      eval "if not @oeaccount.#{thing}.include? value
             flash[:error] = \"Access denied\"
             redirect_to :controller => \'/home\', :action => \'index\'
          end"
     end
  end

  def getmydata(thing)
    data = nil
    if @oeuser.username == "admin"
      eval "data = #{thing}.find(:all)"
    else
      eval "data = #{thing}.find_all_by_account_id(@oeaccount.id)"
    end
    data
  end

  def pagination
    if params[:page].nil?
      @page = 1
    else
      @page = params[:page].to_i
    end
    if @page == 1
      @start = 0
    else
      @start = (@page - 1) * 10
    end
    @stop = @start + 10
  end


  def addevent(type,name,account,user,status,description = nil)
    Event.create(:otype => type, :ntype => name, :status => status, :description => descriptioin, :account => account, :user => user, :ident => SecureRandom.uuid)
  end

  def updateevent(ident,status,description = nil)
    event = Event.find_by_ident(ident)
    event.update_attributes(:status => status, :description => description)
  end

protected
  def authorize
	if not User.find_by_id(session[:user_id]) 
	       flash[:notice] = "Please Log In First"
       	       redirect_to :controller => '/home', :action => 'login'	
	else
		@oeuser = User.find(session[:user_id])
		if not @oeuser.username == "admin"
		@oeaccount = Account.find(session[:user_account])
		end
	end
  end
end
