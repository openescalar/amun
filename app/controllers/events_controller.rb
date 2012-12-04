class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    @events = Event.where("account_id = ?", @oeaccount.id).order("created_at DESC")
    pagination

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @e = params[:ident]
    @events = Event.where("ident = ? and account_id = ?", params[:ident], @oeaccount.id)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :ok }
    end
  end

  def getevent
    #events = Event.where("ident = ? and account_id = ?", params[:ident], @oeaccount.id)
    events = Event.find_by_ident(params[:ident])
    events.status = 0
    childs = []
    events.child.each do |c|
      child = Event.find_by_ident(c)
      childs << child
      case child.status
        when 0
        when 4
           events.status = 4
        else
           events.status = 1
      end
    end
    events.save
    render :partial => "revent", :locals => { :events => events, :childs =>  childs}    
  end
end
