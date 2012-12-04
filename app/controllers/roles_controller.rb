class RolesController < ApplicationController
  before_filter :only => [:show, :edit, :update, :destroy] do |c|
   c.checkaccountobject("roles", Role.find(params[:id]))
  end 

  # GET /roles
  # GET /roles.json
  def index
    @roles = getmydata("Role")
	pagination

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @roles }
    end
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
    @role = Role.find(params[:id])
    checkaccountobject("roles",@role)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @role }
    end
  end

  # GET /roles/new
  # GET /roles/new.json
  def new
    @role = Role.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @role }
    end
  end

  # GET /roles/1/edit
  def edit
    @role = Role.find(params[:id])
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new(params[:role])
    @role.account_id = @oeaccount.id
    respond_to do |format|
      if @role.save
        @role.roletask_ids = params[:roletasks][:ids] if not params[:roletasks].nil?
        format.html { redirect_to roles_url, notice: 'Role was successfully created.' }
        format.json { render json: @role, status: :created, location: @role }
      else
        format.html { render action: "new" }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /roles/1
  # PUT /roles/1.json
  def update
    @role = Role.find(params[:id])
    checkaccountobject("roles",@role)

    respond_to do |format|
      if @role.update_attributes(params[:role])
        #if params[:roletasks][:ids]
          #@server.deployments << Deployment.find(params[:deployments][:ids])
        #  @role.roletask_ids = params[:roletasks][:ids]
        #end

        format.html { redirect_to @role, notice: 'Role was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role = Role.find(params[:id])
    checkaccountobject("roles",@role)
    @role.destroy

    respond_to do |format|
      format.html { redirect_to roles_url }
      format.json { head :ok }
    end
  end

  def roleexec
    role = Role.find(params[:id])
    task = Roletask.find(params[:roletask_id])
    checkaccountobject("roles", role)
    checkaccountobject("roletasks", task)
    if role.roletasks.include?(task)
      Oecoordinator.roleexec(role,task,@oeaccount.id,@oeuser.name)
    end
    respond_to do |format|
      format.html { redirect_to roles_url }
      format.json { head :ok }
    end
  end

end
