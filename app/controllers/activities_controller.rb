class ActivitiesController < ApplicationController
    before_action :set_activity, only: [:show, :edit, :update, :destroy]
    skip_before_action :authenticate_user!, only: [:index, :show, :new, :create]
    before_action :restrict_unless_admin, except: [:index, :show, :new, :create]
  
    def index
      @tags = Activity.select("tags.name").where(state: :active).joins(:taggings).joins("LEFT OUTER JOIN tags on tags.id = taggings.tag_id").distinct
      @activities = Activity.all

      if params[:search].present?
        column_names = Activity.columns.map { |column| column.name if column.type == :string }.compact
        query_string = ''
        column_names.each_with_index do |value, index|
          query_string += index == 0 ? "LOWER(\"#{value}\") LIKE :search" : " OR LOWER(\"#{value}\") LIKE :search"
        end
        @activities = @activities.where(query_string, {search: "%#{params[:search].downcase}%"})
      end

      if params[:tags].present?
        @activities = @activities.tagged_with(params[:tags], any: true)
      end

      @pending_activities = @activities.where(state: :pending)
      @denied_activities = @activities.where(state: :denied)
      @activities = @activities.where(state: :active)

      respond_to do |format|
        format.html { render :index }
        format.json {
          render json: {
            activities: @activities,
            pending_activities: @pending_activities,
            denied_activities: @denied_activities
          },
          status: 200
        }
      end
    end
  
    def show; end
  
    def new
      @activity = Activity.new
    end
  
    def edit
      @activities = Activity.all
    end
  
    def create
      @activity = Activity.new(activity_params)
      @activity.state = current_user&.admin? ? :active : :pending

      if verify_recaptcha && @activity.save
        redirect_to activities_path
        flash[:success] = @activity.active? ? 'Activity was successfully created.' : 'Activity is pending review. It will be available on the dashboard once approved.'
      else
        @activities = Activity.all
        render :new
      end
    end
  
    def update
      if @activity.update(activity_params)
        redirect_to @activity
        flash[:success] = 'Activity was successfully updated.'
      else
        @activities = Activity.all
        render :edit
      end
    end
  
    def destroy
      @activity.destroy
      redirect_to activities_path
      flash[:success] = 'Activity was successfully destroyed.'
    end
  
    private
  
    def set_activity
      @activity = Activity.find(params[:id])
    end
  
    def activity_params
      params.require(:activity).permit(:title,:who,:what,:where,:when_start,:when_end,:how,:details,:tag_list,:state)
    end
  end
  