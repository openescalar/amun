class LoadbalancersController < ApplicationController
  before_filter :only => [:show, :edit, :update, :destroy] do |c|
   c.checkaccountobject("loadbalancers", Loadbalancer.find(params[:id]))
  end

  # GET /loadbalancers
  # GET /loadbalancers.json
  def index
    @loadbalancers = getmydata("Loadbalancer")
    pagination

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @loadbalancers }
    end
  end

  # GET /loadbalancers/1
  # GET /loadbalancers/1.json
  def show
    @loadbalancer = Loadbalancer.find(params[:id])
    checkaccountobject("loadbalancers",@loadbalancer)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @loadbalancer }
    end
  end

  # GET /loadbalancers/new
  # GET /loadbalancers/new.json
  def new
    @loadbalancer = Loadbalancer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @loadbalancer }
    end
  end

  # GET /loadbalancers/1/edit
  def edit
    @loadbalancer = Loadbalancer.find(params[:id])
  end

  # POST /loadbalancers
  # POST /loadbalancers.json
  def create
    @loadbalancer = Loadbalancer.new(params[:loadbalancer])
    @loadbalancer.account_id = @oeaccount.id
    respond_to do |format|
      if @loadbalancer.save
        format.html { redirect_to loadbalancers_url, notice: 'Loadbalancer was successfully created.' }
        format.json { render json: @loadbalancer, status: :created, location: @loadbalancer }
      else
        format.html { render action: "new" }
        format.json { render json: @loadbalancer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /loadbalancers/1
  # PUT /loadbalancers/1.json
  def update
    @loadbalancer = Loadbalancer.find(params[:id])
    checkaccountobject("loadbalancers",@loadbalancer)
    respond_to do |format|
      if @loadbalancer.update_attributes(params[:loadbalancer])
        format.html { redirect_to @loadbalancer, notice: 'Loadbalancer was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @loadbalancer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loadbalancers/1
  # DELETE /loadbalancers/1.json
  def destroy
    @loadbalancer = Loadbalancer.find(params[:id])
    checkaccountobject("loadbalancers",@loadbalancer)
    @loadbalancer.send_delete

    respond_to do |format|
      format.html { redirect_to loadbalancers_url }
      format.json { head :ok }
    end
  end

  # GET /servers/update_zone_select
  def update_zone_select
     azonebyzone = Azone.where("zone_id = ?", params[:id]) unless params[:id].blank?
    render :partial => "byzone", :locals => { :azonebyzone => azonebyzone }
  end


end
