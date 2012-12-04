class VpnsController < ApplicationController
  # GET /vpns
  # GET /vpns.json
  def index
    @vpns = Vpn.all
	pagination

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vpns }
    end
  end

  # GET /vpns/1
  # GET /vpns/1.json
  def show
    @vpn = Vpn.find(params[:id])
    checkaccountobject("vpns",@vpn)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vpn }
    end
  end

  # GET /vpns/new
  # GET /vpns/new.json
  def new
    @vpn = Vpn.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vpn }
    end
  end

  # GET /vpns/1/edit
  def edit
    @vpn = Vpn.find(params[:id])
  end

  # POST /vpns
  # POST /vpns.json
  def create
    @vpn = Vpn.new(params[:vpn])
    @vpn.account_id = @oeaccount.id
    respond_to do |format|
      if @vpn.save
        format.html { redirect_to @vpn, notice: 'Vpn was successfully created.' }
        format.json { render json: @vpn, status: :created, location: @vpn }
      else
        format.html { render action: "new" }
        format.json { render json: @vpn.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /vpns/1
  # PUT /vpns/1.json
  def update
    @vpn = Vpn.find(params[:id])
    checkaccountobject("vpns",@vpn)

    respond_to do |format|
      if @vpn.update_attributes(params[:vpn])
        format.html { redirect_to @vpn, notice: 'Vpn was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @vpn.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vpns/1
  # DELETE /vpns/1.json
  def destroy
    @vpn = Vpn.find(params[:id])
    checkaccountobject("vpns",@vpn)
    @vpn.send_delete

    respond_to do |format|
      format.html { redirect_to vpns_url }
      format.json { head :ok }
    end
  end
end
