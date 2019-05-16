class ActivitiesController < ApplicationController
    before_action :set_activity, only: [:show, :edit, :update, :destroy]
    skip_before_action :authenticate_user!, only: [:index, :show]
    before_action :restrict_unless_admin, except: [:index, :show]
  
    def index
      @activities = Activity.all
      @tags = ActsAsTaggableOn::Tag.all
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
  