class WorkflowsController < ApplicationController
  before_filter :only => [:show, :edit, :update, :destroy, :addtask, :deltask] do |c|
   c.checkaccountobject("workflows", Workflow.find(params[:id]))
  end

  # GET /workflows
  # GET /workflows.json
  def index
    @workflows = getmydata("Workflow")
	pagination

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @workflows }
    end
  end

  # GET /workflows/1
  # GET /workflows/1.json
  def show
    @workflow = Workflow.find(params[:id])
    checkaccountobject("workflows",@workflow)
    @roletask = @workflow.flow
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @workflow }
    end
  end

  # GET /workflows/new
  # GET /workflows/new.json
  def new
    @workflow = Workflow.new
    @roles = @oeaccount.roles

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @workflow }
    end
  end

  # GET /workflows/1/edit
  def edit
    @workflow = Workflow.find(params[:id])
  end

  # POST /workflows
  # POST /workflows.json
  def create
    @workflow = Workflow.new(params[:workflow])
    @workflow.account_id = @oeaccount.id
    respond_to do |format|
      if @workflow.save
        format.html { redirect_to workflows_url, notice: 'Workflow was successfully created.' }
        format.json { render json: @workflow, status: :created, location: @workflow }
      else
        format.html { render action: "new" }
        format.json { render json: @workflow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /workflows/1
  # PUT /workflows/1.json
  def update
    @workflow = Workflow.find(params[:id])
    checkaccountobject("workflows",@workflow)

    respond_to do |format|
      if @workflow.update_attributes(params[:workflow])
        format.html { redirect_to @workflow, notice: 'Workflow was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @workflow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workflows/1
  # DELETE /workflows/1.json
  def destroy
    @workflow = Workflow.find(params[:id])
    checkaccountobject("workflows",@workflow)
    @workflow.destroy

    respond_to do |format|
      format.html { redirect_to workflows_url }
      format.json { head :ok }
    end
  end

  def addtask
    checkaccountobject("roletasks", Roletask.find(params[:task]))
    workflow = Workflow.find(params[:id])
    roletask = Roletask.find(params[:task])
    workflow.roletasks << roletask
    render :partial => "flowtasks", :locals => { :task => workflow.flow, :workflow => workflow }
  end

  def deltask
    checkaccountobject("roletasks", Roletask.find(params[:task]))
    workflow = Workflow.find(params[:id])
    roletask = Roletask.find(params[:task])
    workflow.roletasks.delete(roletask)
    render :partial => "flowtasks", :locals => { :task => workflow.flow, :workflow => workflow }
  end
  
end
