class OffersController < ApplicationController
  before_filter :only => [:show, :edit, :update, :destroy] do |c|
   c.checkaccountobject("offers", Offer.find(params[:id]))
  end

#  before_filter :checkuser
  # GET /offers
  # GET /offers.json
  def index
      @offers = getmydata("Offer")
	pagination

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @offers }
    end
  end

  # GET /offers/1
  # GET /offers/1.json
  def show
    @offer = Offer.find(params[:id])
    checkaccountobject("offers",@offer)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @offer }
    end
  end

  # GET /offers/new
  # GET /offers/new.json
  def new
    @offer = Offer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @offer }
    end
  end

  # GET /offers/1/edit
  def edit
    @offer = Offer.find(params[:id])
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(params[:offer])
    @offer.account_id = @oeaccount.id
    respond_to do |format|
      if @offer.save
        format.html { redirect_to offers_url, notice: 'Offer was successfully created.' }
        format.json { render json: @offer, status: :created, location: @offer }
      else
        format.html { render action: "new" }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /offers/1
  # PUT /offers/1.json
  def update
    @offer = Offer.find(params[:id])
    checkaccountobject("offers",@offer)
    respond_to do |format|
      if @offer.update_attributes(params[:offer])
        format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    @offer = Offer.find(params[:id])
    checkaccountobject("offers",@offer)
    @offer.destroy

    respond_to do |format|
      format.html { redirect_to offers_url }
      format.json { head :ok }
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
