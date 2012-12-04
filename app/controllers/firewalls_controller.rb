class FirewallsController < ApplicationController
  before_filter :only => [:show, :edit, :update, :destroy] do |c|
   c.checkaccountobject("firewalls", Firewall.find(params[:id]))
  end

  # GET /firewalls
  # GET /firewalls.json
  def index
    @firewalls = getmydata("Firewall")
    pagination

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @firewalls }
    end
  end

  # GET /firewalls/1
  # GET /firewalls/1.json
  def show
    @firewall = Firewall.find(params[:id])
    checkaccountobject("firewalls",@firewall)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @firewall }
    end
  end

  # GET /firewalls/new
  # GET /firewalls/new.json
  def new
    @firewall = Firewall.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @firewall }
    end
  end

  # GET /firewalls/1/edit
  def edit
    @firewall = Firewall.find(params[:id])
  end

  # POST /firewalls
  # POST /firewalls.json
  def create
    @firewall = Firewall.new(params[:firewall])
    @firewall.account_id = @oeaccount.id
    respond_to do |format|
      if @firewall.save 
        @firewall.send_create
        format.html { redirect_to firewalls_url, notice: 'Firewall was successfully created.' }
        format.json { render json: @firewall, status: :created, location: @firewall }
      else
        format.html { render action: "new" }
        format.json { render json: @firewall.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /firewalls/1
  # PUT /firewalls/1.json
  def update
    @firewall = Firewall.find(params[:id])
    checkaccountobject("firewalls",@firewall)
    respond_to do |format|
      if @firewall.update_attributes(params[:firewall])
        @firewall.send_update
        format.html { redirect_to @firewall, notice: 'Firewall was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @firewall.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /firewalls/1
  # DELETE /firewalls/1.json
  def destroy
    @firewall = Firewall.find(params[:id])
    checkaccountobject("firewalls",@firewall)
    @firewall.send_delete
    respond_to do |format|
      format.html { redirect_to firewalls_url }
      format.json { head :ok }
    end
  end

  # GET /servers/update_zone_select
  def update_zone_select
     azonebyzone = Azone.where("zone_id = ?", params[:id]) unless params[:id].blank?
    render :partial => "byzone", :locals => { :azonebyzone => azonebyzone }
  end

end
