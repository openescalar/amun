class KeypairsController < ApplicationController
  before_filter :only => [:show, :edit, :update, :destroy] do |c|
   c.checkaccountobject("keypairs", Keypair.find(params[:id]))
  end

  # GET /keypairs
  # GET /keypairs.json
  def index
    @keypairs = getmydata("Keypair")
    pagination

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @keypairs }
    end
  end

  # GET /keypairs/1/download
  def download
    @keypair = Keypair.find(params[:id])
    send_data @keypair.private, :filename => "#{@keypair.name}.pem"
  end

  # GET /keypairs/1
  # GET /keypairs/1.json
  def show
    @keypair = Keypair.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @keypair }
    end
  end

  # GET /keypairs/new
  # GET /keypairs/new.json
  def new
    @keypair = Keypair.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @keypair }
    end
  end

  # GET /keypairs/1/edit
  def edit
    @keypair = Keypair.find(params[:id])
  end

  # POST /keypairs
  # POST /keypairs.json
  def create
    @keypair = Keypair.new(params[:keypair])
    @keypair.account_id = @oeaccount.id
    respond_to do |format|
      if @keypair.save
        @keypair.send_create
        format.html { redirect_to @keypair, notice: 'Keypair was successfully created.' }
        format.json { render json: @keypair, status: :created, location: @keypair }
      else
        format.html { render action: "new" }
        format.json { render json: @keypair.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /keypairs/1
  # PUT /keypairs/1.json
  def update
    @keypair = Keypair.find(params[:id])

    respond_to do |format|
      if @keypair.update_attributes(params[:keypair])
        format.html { redirect_to @keypair, notice: 'Keypair was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @keypair.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keypairs/1
  # DELETE /keypairs/1.json
  def destroy
    @keypair = Keypair.find(params[:id])
    
    #@keypair.destroy
    @keypair.send_delete
    respond_to do |format|
      format.html { redirect_to keypairs_url }
      format.json { head :ok }
    end
  end

  # POST /keypairs/1/import/zoneid
  def import
    @keypair = Keypair.find(params[:id])
    @zone = Zone.find(params[:zid])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @keypair }
    end

  end

  # GET /servers/update_zone_select
  def update_zone_select
     azonebyzone = Azone.where("zone_id = ?", params[:id]) unless params[:id].blank?
    render :partial => "byzone", :locals => { :azonebyzone => azonebyzone }
  end
end
