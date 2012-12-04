class ZonesController < ApplicationController
  before_filter :only => [:show, :edit, :update, :destroy] do |c| 
    c.checkaccountobject("zones", Zone.find(params[:id])) 
  end

  # POST /zones/id/import
  #def importResources
  #  @z = Zone.find(params[:id])
  #  @z.send_import
  #  respond_to do |format|
  #        format.html { redirect_to @z, notice: 'Importing Resources from #{@zone.name}.' }
  #  end
  #end

  # POST /zones/enable/
  def enableCloud
    if params[:cloud] and params[:name]
     case params[:cloud]
       when "aws-us-east1"
	z = Zone.create(:name => params[:name], :entrypoint => "ec2.us-east-1.amazonaws.com", :apitype => "AWS", :key => "changeme", :secret => "changeme", :account_id => @oeaccount.id)
	Azone.create(:name => "us-east-1a", :status => "online", :zone_id => z.id)
	Azone.create(:name => "us-east-1b", :status => "online", :zone_id => z.id)
	Azone.create(:name => "us-east-1c", :status => "online", :zone_id => z.id)
	Azone.create(:name => "us-east-1d", :status => "online", :zone_id => z.id)
	Azone.create(:name => "us-east-1e", :status => "online", :zone_id => z.id)
       when "aws-us-west1"
	z = Zone.create(:name => params[:name], :entrypoint => "ec2.us-west-1.amazonaws.com", :apitype => "AWS", :key => "changeme", :secret => "changeme", :account_id => @oeaccount.id)
	Azone.create(:name => "us-west-1a", :status => "online", :zone_id => z.id)
	Azone.create(:name => "us-west-1b", :status => "online", :zone_id => z.id)
	Azone.create(:name => "us-west-1c", :status => "online", :zone_id => z.id)
       when "aws-us-west2"
	z = Zone.create(:name => params[:name], :entrypoint => "ec2.us-west-2.amazonaws.com", :apitype => "AWS", :key => "changeme", :secret => "changeme", :account_id => @oeaccount.id)
	Azone.create(:name => "us-west-2a", :status => "online", :zone_id => z.id)
	Azone.create(:name => "us-west-2b", :status => "online", :zone_id => z.id)
	Azone.create(:name => "us-west-2c", :status => "online", :zone_id => z.id)
       when "aws-eu1"
	z = Zone.create(:name => params[:name], :entrypoint => "ec2.eu-west-1.amazonaws.com", :apitype => "AWS", :key => "changeme", :secret => "changeme", :account_id => @oeaccount.id)
	Azone.create(:name => "eu-west-1a", :status => "online", :zone_id => z.id)
	Azone.create(:name => "eu-west-1b", :status => "online", :zone_id => z.id)
	Azone.create(:name => "eu-west-1c", :status => "online", :zone_id => z.id)
       when "aws-ap1"
	z = Zone.create(:name => params[:name], :entrypoint => "ec2.ap-southeast-1.amazonaws.com", :apitype => "AWS", :key => "changeme", :secret => "changeme", :account_id => @oeaccount.id)
	Azone.create(:name => "ap-southeast-1a", :status => "online", :zone_id => z.id)
	Azone.create(:name => "ap-southeast-1b", :status => "online", :zone_id => z.id)
	Azone.create(:name => "ap-southeast-1c", :status => "online", :zone_id => z.id)
       when "aws-ap2"
	z = Zone.create(:name => params[:name], :entrypoint => "ec2.ap-northeast-1.amazonaws.com", :apitype => "AWS", :key => "changeme", :secret => "changeme", :account_id => @oeaccount.id)
	Azone.create(:name => "ap-northeast-1a", :status => "online", :zone_id => z.id)
	Azone.create(:name => "ap-northeast-1b", :status => "online", :zone_id => z.id)
       when "aws-sa1"
	z = Zone.create(:name => params[:name], :entrypoint => "ec2.sa-east-1.amazonaws.com", :apitype => "AWS", :key => "changeme", :secret => "changeme", :account_id => @oeaccount.id)
	Azone.create(:name => "sa-east-1a", :status => "online", :zone_id => z.id)
	Azone.create(:name => "sa-east-1b", :status => "online", :zone_id => z.id)
       when "hp-us1"
	z = Zone.create(:name => params[:name], :entrypoint => "region-a.geo-1.identity.hpcloudsvc.com", :apitype => "HPOS", :key => "changeme", :secret => "changeme", :account_id => @oeaccount.id)
	Azone.create(:name => "az-1.region-a.geo-1", :status => "online", :endpoint => "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/", :zone_id => z.id)
	Azone.create(:name => "az-2.region-a.geo-1", :status => "online", :endpoint => "https://az-2.region-a.geo-1.compute.hpcloudsvc.com/v1.1/", :zone_id => z.id)
	Azone.create(:name => "az-3.region-a.geo-1", :status => "online", :endpoint => "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/", :zone_id => z.id)
       when "rs-us"
        z = Zone.create(:name => params[:name], :entrypoint => "identity.api.rackspacecloud.com", :apitype => "RSOPEN", :key => "changeme", :secret => "changeme", :account_id => @oeaccount.id )
	Azone.create(:name => "dfw.servers", :status => "online", :endpoint => "https://dfw.servers.api.rackspacecloud.com/v2/", :zone_id => z.id)
	Azone.create(:name => "ord.servers", :status => "online", :endpoint => "https://ord.servers.api.rackspacecloud.com/v2/", :zone_id => z.id)
       when "rs-uk"
        z = Zone.create(:name => params[:name], :entrypoint => "lon.identity.api.rackspacecloud.com", :apitype => "RSOPEN", :key => "changeme", :secret => "changeme", :account_id => @oeaccount.id )
	Azone.create(:name => "lon.servers", :status => "online", :endpoint => "https://lon.servers.api.rackspacecloud.com/v2/", :zone_id => z.id)
    end
    respond_to do |format|
	if z
          format.html { redirect_to z, notice: 'Zone was successfully created.' }
        else
          format.html { redirect_to zones_url }
        end
    end
   end  
  end

#  before_filter :checkuser
  # GET /zones
  # GET /zones.json
  def index
    @zones = getmydata("Zone")
	pagination

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @zones }
    end
  end

  # GET /zones/1
  # GET /zones/1.json
  def show
    @zone = Zone.find(params[:id])
    checkaccountobject("zones",@zone)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @zone }
    end
  end

  # GET /zones/new
  # GET /zones/new.json
  def new
    @zone = Zone.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @zone }
    end
  end

  # GET /zones/1/edit
  def edit
    @zone = Zone.find(params[:id])
  end

  # POST /zones
  # POST /zones.json
  def create
    @zone = Zone.new(params[:zone])
    @zone.account_id = @oeaccount.id

    respond_to do |format|
      if @zone.save
        format.html { redirect_to zones_url, notice: 'Zone was successfully created.' }
        format.json { render json: @zone, status: :created, location: @zone }
      else
        format.html { render action: "new" }
        format.json { render json: @zone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /zones/1
  # PUT /zones/1.json
  def update
    @zone = Zone.find(params[:id])
    checkaccountobject("zones",@zone)

    respond_to do |format|
      if @zone.update_attributes(params[:zone])
        format.html { redirect_to @zone, notice: 'Zone was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @zone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /zones/1
  # DELETE /zones/1.json
  def destroy
    @zone = Zone.find(params[:id])
    checkaccountobject("zones",@zone)
    @zone.destroy

    respond_to do |format|
      format.html { redirect_to zones_url }
      format.json { head :ok }
    end
  end
 
  def serverbyoffer
    @sxo = []
    @oeaccount.zones.each {|z| z.offers.each {|o| @sxo << [o.code.to_s,o.servers.size] }}
    respond_to do |format|
      format.json { render json: @sxo }
    end
  end

  def serverbyimage
    @sxi = []
    @oeaccount.zones.each {|z| z.images.each {|i| @sxi << [i.serial,i.servers.size] }}
    respond_to do |format|
      format.json { render json: @sxi }
    end
  end

  def costbyzone
    @cxz = []
    @oeaccount.zones.each {|z| b = 0 ; z.servers.each {|s| b += (s.updated_at - s.created_at).to_i/3600 } ; @cxz << {"name" => z.name,"data" => [b]} }
    respond_to do |format|
      format.json { render json: @cxz }
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
