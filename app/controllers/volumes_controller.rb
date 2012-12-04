class VolumesController < ApplicationController
  before_filter :only => [:show, :edit, :update, :destroy] do |c|
   c.checkaccountobject("volumes", Volume.find(params[:id]))
  end

  # GET /volumes
  # GET /volumes.json
  def index
    @volumes = getmydata("Volume")
	pagination

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @volumes }
    end
  end

  # GET /volumes/1
  # GET /volumes/1.json
  def show
    @volume = Volume.find(params[:id])
    checkaccountobject("volumes",@volume)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @volume }
    end
  end

  # GET /volumes/new
  # GET /volumes/new.json
  def new
    @volume = Volume.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @volume }
    end
  end

  # GET /volumes/1/edit
  def edit
    @volume = Volume.find(params[:id])
  end

  # POST /volumes
  # POST /volumes.json
  def create
    @volume = Volume.new(params[:volume])
    @volume.account_id = @oeaccount.id
    respond_to do |format|
      if @volume.save 
        @volume.send_create
        format.html { redirect_to volumes_url, notice: 'Volume was successfully created.' }
        format.json { render json: @volume, status: :created, location: @volume }
      else
        format.html { render action: "new" }
        format.json { render json: @volume.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /volumes/1
  # PUT /volumes/1.json
  def update
    @volume = Volume.find(params[:id])
    checkaccountobject("volumes",@volume)
    respond_to do |format|
      if @volume.update_attributes(params[:volume])
        @volume.send_update
        format.html { redirect_to @volume, notice: 'Volume was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @volume.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /volumes/1
  # DELETE /volumes/1.json
  def destroy
    @volume = Volume.find(params[:id])
    checkaccountobject("volumes",@volume)
    @volume.send_delete
    respond_to do |format|
      format.html { redirect_to volumes_url }
      format.json { head :ok }
    end
  end

  # GET /servers/update_zone_select
  def update_zone_select
     azonebyzone = Azone.where("zone_id = ?", params[:id]) unless params[:id].blank?
    render :partial => "byzone", :locals => { :azonebyzone => azonebyzone }
  end



end
