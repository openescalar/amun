class RulesController < ApplicationController
  before_filter :only => [:show, :edit, :update, :destroy] do |c|
   c.checkaccountobject("rules", Rule.find(params[:id]))
  end

  # GET /rules
  # GET /rules.json
  def index
    @rules = getmydata("Rule")
	pagination

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rules }
    end
  end

  # GET /rules/1
  # GET /rules/1.json
  def show
    @rule = Rule.find(params[:id])
    checkaccountobject("rules",@rule)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rule }
    end
  end

  # GET /rules/new
  # GET /rules/new.json
  def new
    @rule = Rule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rule }
    end
  end

  # GET /rules/1/edit
  def edit
    @rule = Rule.find(params[:id])
  end

  # POST /rules
  # POST /rules.json
  def create
    @rule = Rule.new(params[:rule])
    @rule.account_id = @oeaccount.id
    respond_to do |format|
      if @rule.save
        @rule.send_create
        format.html { redirect_to rules_url, notice: 'Rule was successfully created.' }
        format.json { render json: @rule, status: :created, location: @rule }
      else
        format.html { render action: "new" }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rules/1
  # PUT /rules/1.json
  def update
    @rule = Rule.find(params[:id])
    checkaccountobject("rules",@rule)

    respond_to do |format|
      if @rule.update_attributes(params[:rule])
        @rule.send_update
        format.html { redirect_to @rule, notice: 'Rule was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rules/1
  # DELETE /rules/1.json
  def destroy
    @rule = Rule.find(params[:id])
    checkaccountobject("rules",@rule)
    @rule.send_delete
    respond_to do |format|
      format.html { redirect_to rules_url }
      format.json { head :ok }
    end
  end
end
