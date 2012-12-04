class ServersController < ApplicationController
  before_filter :only => [:show, :edit, :update, :destroy, :getlog] do |c|
   c.checkaccountobject("servers", Server.find(params[:id]))
  end

  # GET /servers
  # GET /servers.json
  def index
    @servers = getmydata("Server")
	pagination

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @servers }
    end
  end

  # GET /servers/1
  # GET /servers/1.json
  def show
    @server = Server.find(params[:id])
    checkaccountobject("servers",@server)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @server }
    end
  end

  # GET /servers/new
  # GET /servers/new.json
  def new
    @server = Server.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @server }
    end
  end

  # GET /servers/1/edit
  def edit
    @server = Server.find(params[:id])
  end

  # POST /servers
  # POST /servers.json
  def create
    @server = Server.new(params[:server])
    @server.account_id = @oeaccount.id   
    respond_to do |format|
      if @server.save
        @server.send_create
        # NOTE TO MYSELF YOU NEED TO CHECK IF THE DEPLOYMENTS AND ROLES BELONG TO THE USER
	if params[:deployment_ids]
          #@server.deployments << Deployment.find(params[:deployments][:ids])
          @server.deployment_ids = params[:deployment_ids]
	end
	if params[:role_ids]
          #@server.roles << Role.find(params[:roles][:ids])
          @server.role_ids = params[:role_ids]
	end
        format.html { redirect_to servers_url, notice: 'Server was successfully created.' }
        format.json { render json: @server, status: :created, location: @server }
      else
        format.html { render action: "new" }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /servers/1
  # PUT /servers/1.json
  def update
    @server = Server.find(params[:id])
    checkaccountobject("servers",@server)
    respond_to do |format|
      if @server.update_attributes(params[:server])
        @server.send_update
        format.html { redirect_to @server, notice: 'Server was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /servers/1
  # DELETE /servers/1.json
  def destroy
    @server = Server.find(params[:id])
    checkaccountobject("servers",@server)
    @server.send_delete
    respond_to do |format|
      format.html { redirect_to servers_url }
      format.json { head :ok }
    end
  end

  # POST /servers/1/taskexec/roletask_id

  def taskexec
    server = Server.find(params[:id])
    role = Role.find(params[:role_id])
    task = Roletask.find(params[:roletask_id])
    checkaccountobject("servers",server)
    checkaccountobject("roles",role)
    checkaccountobject("roletasks",task)
    if server.roles.include?(role) and role.roletasks.include?(task)
      Oecoordinator.taskexec(server,role,task,@oeaccount.name,@oeuser.name)
    end
    respond_to do |format|
      format.html { redirect_to server, :notice => 'Task Executed' }
    end
  end

  # GET /servers/update_zone_select
  def update_zone_select
     offersbyzone = Offer.where("zone_id = ?", params[:id]) unless params[:id].blank?
     imagesbyzone = Image.where("zone_id = ?", params[:id]) unless params[:id].blank?
     azonebyzone = Azone.where("zone_id = ?", params[:id]) unless params[:id].blank?
     keypairbyzone = Keypair.where("zone_id = ?", params[:id]) unless params[:id].blank?
     firewallsbyzone = Firewall.where("zone_id = ?", params[:id]) unless params[:id].blank?
     loadbalancersbyzone = Loadbalancer.where("zone_id = ?", params[:id]) unless params[:id].blank?
    render :partial => "byzone", :locals => { :offersbyzone => offersbyzone, :imagesbyzone => imagesbyzone, :firewallsbyzone => firewallsbyzone, :loadbalancersbyzone => loadbalancersbyzone, :azonebyzone => azonebyzone, :keypairbyzone => keypairbyzone }
  end

  # GET /servers/1/getlog
  def getlog
    @server = Server.find(params[:id])
    logios = @server.getlog
    render :partial => "log", :locals => { :logios => logios }
  end

end
