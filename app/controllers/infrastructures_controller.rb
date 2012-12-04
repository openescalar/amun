class InfrastructuresController < ApplicationController
  before_filter :only => [:show, :edit, :update, :destroy] do |c|
   c.checkaccountobject("infrastructures", Infrastructure.find(params[:id]))
  end

  # GET /infrastructures
  # GET /infrastructures.json
  def index
    @infrastructures = getmydata("Infrastructure")
    pagination

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @infrastructures }
    end
  end

  # GET /infrastructures/1
  # GET /infrastructures/1.json
  def show
    @infrastructure = Infrastructure.find(params[:id])
    checkaccountobject("infrastructures",@infrastructure)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @infrastructure }
    end
  end

  # GET /infrastructures/new
  # GET /infrastructures/new.json
  def new
    @infrastructure = Infrastructure.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @infrastructure }
    end
  end

  # GET /infrastructures/1/edit
  def edit
    @infrastructure = Infrastructure.find(params[:id])
  end

  # POST /infrastructures
  # POST /infrastructures.json
  def create
    @infrastructure = Infrastructure.new(params[:infrastructure])
    @infrastructure.account_id = @oeaccount.id
    respond_to do |format|
      if @infrastructure.save
        format.html { redirect_to infrastructures_url, notice: 'Infrastructure was successfully created.' }
        format.json { render json: @infrastructure, status: :created, location: @infrastructure }
      else
        format.html { render action: "new" }
        format.json { render json: @infrastructure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /infrastructures/1
  # PUT /infrastructures/1.json
  def update
    @infrastructure = Infrastructure.find(params[:id])
    checkaccountobject("infrastructures",@infrastructure)

    respond_to do |format|
      if @infrastructure.update_attributes(params[:infrastructure])
        format.html { redirect_to @infrastructure, notice: 'Infrastructure was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @infrastructure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /infrastructures/1
  # DELETE /infrastructures/1.json
  def destroy
    @infrastructure = Infrastructure.find(params[:id])
    checkaccountobject("infrastructures",@infrastructure)
    @infrastructure.send_delete

    respond_to do |format|
      format.html { redirect_to infrastructures_url }
      format.json { head :ok }
    end
  end
 
  # post /infrastructure/1/build
  def build
    @infrastructure = Infrastructure.find(params[:id])
    checkaccountobject("infrastructures",@infrastructure)
    flash[:error] = @infrastructure.build
    @infrastructure.send_create if not flash[:error]
    respond_to do |format|
      format.html { redirect_to infrastructures_url }
      format.json { head :ok }
    end
  end
end
