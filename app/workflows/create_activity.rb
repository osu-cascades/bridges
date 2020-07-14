class CreateActivity

  attr_reader :activity, :author

  def initialize(activity, author = nil)
    @activity = activity
    @author = author
  end

  def run
    activity.state = activity_state
    activity.save
  end

  def message
    if activity.new_record?
      'Activity not yet saved'
    elsif activity.active?
      'Activity was successfully created.'
    elsif activity.pending?
      'Activity is pending review. It will be publicly visible once approved.'
    end
  end

  private

  def activity_state
    author&.admin? ? :active : :pending
  end

end
