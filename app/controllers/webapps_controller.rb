class WebappsController < ApplicationController

  def index
    @webapps = Webapp.all
  end

  def new
    @organization = Organization.find params[:orgid]
    @webapp = Webapp.new
  end

  def create
    @webapp = Webapp.new post_params
    @webapp.appid = SecureRandom.uuid()
    @webapp.appsecret = SecureRandom.hex(64)
    if @webapp.save
      redirect_to :action => 'show', :id => @webapp.id
    else
      render :action => 'new'
    end
  end

  def edit
    @webapp = Webapp.find params[:id]
  end

  def update
    @webapp = Webapp.find params[:id]
    if @webapp.update_attributes post_params
      redirect_to :action => 'show', :id => @webapp.id
    else
      render :action => :edit
    end
  end

  def destroy
    @webapp = Webapp.find params[:id]
    @webapp.destroy
    redirect_to posts_path
  end

  def show
    @webapp = Webapp.find params[:id]
  end
  
  def chart
    @webapp = Webapp.find params[:id]
    if @webapp.ptobject.nil? or @webapp.ptobject.length < 2
      @ptobj = Hash.new
    else
      @ptobj = JSON.parse(@webapp.ptobject)
    end
    if @ptobj['history'].nil?
      @ptobj['history'] = Array.new
    end
  end
  
  def pt_test
    @trackerurl = "//promtracker-roadlogica.c9users.io/analytics.js"
    @webapp = Webapp.find params[:id]
  end
  
  private
  
  def post_params
    params.require(:webapp).permit(:name, :code, :organization_id, :desc)
  end
  
end