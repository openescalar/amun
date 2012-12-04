class RoletasksController < ApplicationController
  before_filter :only => [:show, :edit, :update, :destroy] do |c|
   c.checkaccountobject("roletasks", Roletask.find(params[:id]))
  end

  # GET /roletasks
  # GET /roletasks.json
  def index
    @roletasks = getmydata("Roletask") 
	pagination

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @roletasks }
    end
  end

  # GET /roletasks/1
  # GET /roletasks/1.json
  def show
    @roletask = Roletask.find(params[:id])
    checkaccountobject("roletasks", @roletask)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @roletask }
    end
  end

  # GET /roletasks/new
  # GET /roletasks/new.json
  def new
    @roletask = Roletask.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @roletask }
    end
  end

  # GET /roletasks/1/edit
  def edit
    @roletask = Roletask.find(params[:id])
  end

  # POST /roletasks
  # POST /roletasks.json
  def create
    @roletask = Roletask.new(params[:roletask])
    @roletask.account_id = @oeaccount.id

    respond_to do |format|
      if @roletask.save
        format.html { redirect_to roletasks_url, notice: 'Roletask was successfully created.' }
        format.json { render json: @roletask, status: :created, location: @roletask }
      else
        format.html { render action: "new" }
        format.json { render json: @roletask.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /roletasks/1
  # PUT /roletasks/1.json
  def update
    @roletask = Roletask.find(params[:id])
    checkaccountobject("roletasks",@roletask)

    respond_to do |format|
      if @roletask.update_attributes(params[:roletask])
        format.html { redirect_to @roletask, notice: 'Roletask was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @roletask.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roletasks/1
  # DELETE /roletasks/1.json
  def destroy
    @roletask = Roletask.find(params[:id])
    checkaccountobject("roletasks",@roletask)
    @roletask.destroy

    respond_to do |format|
      format.html { redirect_to roletasks_url }
      format.json { head :ok }
    end
  end

  def gettask
    @oeaccount = Account.find_by_key(URI.unescape(params[:key]))
    if @oeaccount 
      if Roletask.decryptQuery(params,@oeaccount.secret,@oeaccount.key)
        @task = Roletask.find_by_name(params[:task]).content
        render :layout => 'gettask'
      else
        render :status => 404, :layout => 'gettask'
      end
    else
      render :status => 404, :layout => 'gettask'
    end
  end
  
  def updatetask
    @oeaccount = Account.find_by_key(URI.unescape(params[:key]))
    if @oeaccount
      if Roletask.decryptQuery(params,@oeaccount.secret,@oeaccount.key)
        @eventupdate = Event.where("ident = ? and account = ? and ntype = ? and server = ?", params[:ident], @oeaccount.name, params[:task], params[:server])
        @eventupdate.each do |e|
          if params[:code] == "0"
            e.status = "success"
          else
            e.status = "failed"
          end
          e.description = params[:description] 
          e.save
        end
        render :layout => 'gettask'
      else
        render :status => 404, :layout => 'gettask'
      end
    else
      render :status => 404, :layout => 'gettask'
    end

  end

end
