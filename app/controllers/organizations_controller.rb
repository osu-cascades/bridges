class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :restrict_unless_admin, except: [:index, :show]

  def index
    @tags = Organization.select("tags.name").joins(:taggings).joins("LEFT OUTER JOIN tags on tags.id = taggings.tag_id").distinct
    @organizations = Organization.order(:name)

    if params[:search].present?
      column_names = Organization.columns.map { |column| column.name if [:string, :text].include? column.type }.compact
      query_string = ''
      column_names.each_with_index do |value, index|
        query_string += index == 0 ? "LOWER(\"#{value}\") LIKE :search" : " OR LOWER(\"#{value}\") LIKE :search"
      end
      @organizations = @organizations.where(query_string, {search: "%#{params[:search].downcase}%"})
    end

    if params[:tags].present?
      @organizations = @organizations.tagged_with(params[:tags], any: true)
    end

    respond_to do |format|
      format.html { render :index }
      format.json {
        render json: {
          organizations: @organizations
        },
        status: 200
      }
    end
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
    @organization.logo_url = @organization.logo.attached? ? url_for(@organization.logo) : nil

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
      @organization.logo.purge if (@organization.logo.attached? && params[:logo])
      @organization.logo.attach(params[:logo]) if (params[:logo])
      @organization.logo_url = @organization.logo.attached? ? url_for(@organization.logo) : nil
      @organization.save
      redirect_to @organization
      flash[:success] = 'Organization was successfully updated.'
    else
      @organizations = Organization.all
      render :edit
    end
  end

  def destroy
    @organization.logo.purge
    @organization.destroy
    redirect_to organizations_path
    flash[:success] = 'Organization was successfully destroyed.'
  end

  private

  def set_organization
    @organization = Organization.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:name,:location,:ages_served,:programs,:contact_number,:contact_email,:website,:logo,:state,:tag_list)
  end
end
