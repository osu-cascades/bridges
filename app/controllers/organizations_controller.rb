class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :restrict_unless_admin, except: [:index, :show]

  def index
    @organizations = Organization.all
  end

  def show; end

  def new
    @organization = Organization.new
  end

  def edit
    @organizations = Organization.all
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      redirect_to organizations_path
      flash[:success] = 'Organization was successfully created.'
    else
      @organizations = Organization.all
      render :new
    end
  end

  def update
    if @organization.update(organization_params)
      redirect_to @organization
      flash[:success] = 'Organization was successfully updated.'
    else
      @organizations = Organization.all
      render :edit
    end
  end

  def destroy
    @organization.destroy
    redirect_to organizations_path
    flash[:success] = 'Organization was successfully destroyed.'
  end

  private

  def set_organization
    @organization = Organization.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:name,:location,:ages_served,:programs,:contact_number,:contact_email,:website)
  end
end
