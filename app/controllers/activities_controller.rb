class ActivitiesController < ApplicationController
    before_action :set_activity, only: [:show, :edit, :update, :destroy]
    skip_before_action :authenticate_user!, only: [:index, :show, :new, :create]
    before_action :restrict_unless_admin, except: [:index, :show, :new, :create]
  
    def index
      @tags = ActsAsTaggableOn::Tag.all
      if params[:tags].present?
        @activities = Activity.tagged_with(params[:tags]).where(state: :active)
        @pending_activities = Activity.tagged_with(params[:tags]).where(state: :pending)
        @denied_activities = Activity.tagged_with(params[:tags]).where(state: :denied)
      else
        @activities = Activity.where(state: :active)
        @pending_activities = Activity.where(state: :pending)
        @denied_activities = Activity.where(state: :denied)
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

      if @activity.save
        redirect_to activities_path
        flash[:success] = 'Activity was successfully created.'
      else
        @activities = Activity.all
        render 'new'
      end
    end
  
    def update
      if @activity.update(activity_params)
        redirect_to @activity
        flash[:success] = 'Activity was successfully updated.'
      else
        @activities = Activity.all
        render 'edit'
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
      params.require(:activity).permit(:title,:who,:what,:where,:when,:how,:details,:tag_list)
    end
  end
  