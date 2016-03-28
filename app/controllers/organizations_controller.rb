class OrganizationsController < ApplicationController

  def index
    @organizations_grid = initialize_grid(Organization, per_page: 10)
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new post_params
    @organization.code = SecureRandom.uuid()
    if @organization.save
      redirect_to :action => 'show', :id => @organization.id
    else
      render :action => 'new'
    end
  end

  def edit
    @organization = Organization.find params[:id]
  end

  def update
    @organization = Organization.find params[:id]
    if @organization.update_attributes post_params
      redirect_to :action => 'show', :id => @organization.id
    else
      render :action => :edit
    end
  end

  def destroy
    @organization = Organization.find params[:id]
    @organization.webapps.destroy
    @organization.destroy
    redirect_to organizations_path
  end

  def show
    @organization = Organization.find params[:id]
    @webapps_grid = initialize_grid(@organization.webapps, per_page: 10)
  end
  
  private
  
  def post_params
    params.require(:organization).permit(:name, :code, :desc)
  end
  
end