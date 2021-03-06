class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :restrict_unless_admin, only: [:new, :create, :destroy ]
  before_action :limit_editing_to_organization_members_and_admins, only: [:edit, :update]

  def index
    @tags = Organization.select("tags.name").joins(:taggings).joins("LEFT OUTER JOIN tags on tags.id = taggings.tag_id").distinct
    @organizations = Organization.active.order(:name)
    @inactive_organizations = Organization.inactive.order(:name)
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

    @organizations = @organizations.map { |organization|
      organization.as_json.merge({ image_url: organization.logo.attached? ? url_for(organization.logo) : nil })
    }

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

  def limit_editing_to_organization_members_and_admins
    redirect_to(root_url) unless current_user.organization == @organization || current_user.admin?
  end

  def set_organization
    @organization = Organization.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(
      :name, :location, :ages_served, :programs, :contact_number, :contact_email,
      :website, :logo, :state, :description, :tag_list, :active)
  end
end
