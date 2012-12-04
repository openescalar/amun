class UsersController < ApplicationController
  before_filter :checkuser, :except => [:invite, :achange, :update, :show, :edit]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
	pagination

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if @oeuser.id.to_i == params[:id].to_i
      @user = User.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    else
        flash[:error] = "Restricted Access, You need to be Admin"
        redirect_to root_url
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    if @oeuser.id.to_i == params[:id].to_i
      @user = User.find(params[:id])
    else
        flash[:error] = "Restricted Access, You need to be Admin"
        redirect_to root_url
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
	UserMailer.welcome_email(@user).deliver
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/change_account/1

  def achange
    nextaccount = params[:id]
    if @oeuser.account_ids.include? nextaccount.to_i
      session[:user_account] = nextaccount
    end
    redirect_to :controller => "/home", :action => 'index'
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    if @oeuser.id.to_i == params[:id].to_i
      @user = User.find(params[:id])
      if params[:oldpassword] and params[:newpassword] and params[:confirmpassword]
        @user.errors.add(:password, "Current password doesn't match") if not @user.checkpass(params[:oldpassword])
        @user.errors.add(:password, "New and confirmation password doesn't match") if not params[:newpassword] == params[:confirmpassword]
        if @user.errors.empty? 
          @user.password = params[:newpassword]
        end
      end
      respond_to do |format|
        if @user.errors.empty? and @user.update_attributes(params[:user])
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
        flash[:error] = "Restricted Access, You need to be Admin"
        redirect_to root_url
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end

  # GET/POST /users/invite

  def invite
    if request.post? 
        user = User.find_by_username(params[:uname])
	if user and @oeaccount.users[0] == @oeuser
          @oeaccount.users << user
	  UserMailer.invite_email(user,@oeaccount,@oeaccount.users[0]).deliver
	  flash[:notice] = "User invited"
	  respond_to do |format|
	    format.html { redirect_to root_url }
	    format.json { head :ok }
	  end
        else
	  flash[:error] = "User was not invited because you are not the owner of the account or the user doesnt exist"
	  respond_to do |format|
	    format.html { redirect_to root_url }
	    format.json { head :ok }
	  end
       end
    else
      respond_to do |format|
        format.html 
        format.json { render json: @user }
      end
    end
  end
protected
  def checkuser
    unless @oeuser.id == 1 and @oeuser.username == "admin"
        flash[:error] = "Restricted Access, You need to be Admin"
        redirect_to root_url
    end
  end
 
end
