class DeploymentsController < ApplicationController
  before_filter :only => [:show, :edit, :update, :destroy, :deploy, :deployworkflow] do |c| 
   c.checkaccountobject("deployments", Deployment.find(params[:id]))
  end
  # GET /deployments
  # GET /deployments.json
  def index
    @deployments = getmydata("Deployment")
    pagination

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @deployments }
    end
  end

  # GET /deployments/1
  # GET /deployments/1.json
  def show
    @deployment = Deployment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @deployment }
    end
  end

  # GET /deployments/new
  # GET /deployments/new.json
  def new
    @deployment = Deployment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @deployment }
    end
  end

  # GET /deployments/1/edit
  def edit
    @deployment = Deployment.find(params[:id])
  end

  # POST /deployments
  # POST /deployments.json
  def create
    @deployment = Deployment.new(params[:deployment])
    @deployment.account_id = @oeaccount.id

    respond_to do |format|
      if @deployment.save
        format.html { redirect_to deployments_url, notice: 'Deployment was successfully created.' }
        format.json { render json: @deployment, status: :created, location: @deployment }
      else
        format.html { render action: "new" }
        format.json { render json: @deployment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /deployments/1
  # PUT /deployments/1.json
  def update
    @deployment = Deployment.find(params[:id])
    checkaccountobject("deployments", @deployment) 
    respond_to do |format|
      if @deployment.update_attributes(params[:deployment])
        format.html { redirect_to @deployment, notice: 'Deployment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @deployment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deployments/1
  # DELETE /deployments/1.json
  def destroy
    @deployment = Deployment.find(params[:id])
    checkaccountobject("deployments", @deployment)
    @deployment.destroy

    respond_to do |format|
      format.html { redirect_to deployments_url }
      format.json { head :ok }
    end
  end
  
  def deploy
    eid = Oecoordinator.mydeployordered(params[:id], @oeaccount.id, @oeuser.name)
    respond_to do |format|
      format.html { redirect_to :controller => 'events', :action => 'show', :ident => eid }
      format.json { head :ok }
    end
  end
  
  def deployworkflow
    deployment = Deployment.find(params[:id])
    workflow = Workflow.find(params[:wf])
    if deployment.workflows.include? workflow
      eid = Oecoordinator.myworkflowordered(deployment.id, workflow.id, @oeaccount.id, @oeuser.name)
    end
    respond_to do |format|
      format.html { redirect_to :controller => 'events', :action => 'show', :ident => eid }
      format.json { head :ok }
    end
  end
end
