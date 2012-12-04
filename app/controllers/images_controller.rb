class ImagesController < ApplicationController
  before_filter :only => [:show, :edit, :update, :destroy] do |c|
   c.checkaccountobject("images", Image.find(params[:id]))
  end

  # GET /images
  # GET /images.json
  def index
    @images = getmydata("Image")
    pagination

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @images }
    end
  end

  # GET /images/1
  # GET /images/1.json
  def show
    @image = Image.find(params[:id])
    checkaccountobject("images",@image)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/new
  # GET /images/new.json
  def new
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(params[:image])
    @image.account_id = @oeaccount.id
    respond_to do |format|
      if @image.save
        format.html { redirect_to images_url, notice: 'Image was successfully created.' }
        format.json { render json: @image, status: :created, location: @image }
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /images/1
  # PUT /images/1.json
  def update
    @image = Image.find(params[:id])
    checkaccountobject("images",@image)
    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image = Image.find(params[:id])
    checkaccountobject("images",@image)
    cloud = Oecloud.new(:zone => @image.zone, :image => @image)
    if cloud.deregisterimage
      @image.destroy
    end

    respond_to do |format|
      format.html { redirect_to images_url }
      format.json { head :ok }
    end
  end

  # GET /servers/update_zone_select
  def update_zone_select
     azonebyzone = Azone.where("zone_id = ?", params[:id]) unless params[:id].blank?
    render :partial => "byzone", :locals => { :azonebyzone => azonebyzone }
  end

end
