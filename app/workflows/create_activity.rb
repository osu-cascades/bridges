class CreateActivity

  attr_reader :activity

  def initialize(activity)
    @activity = activity
  end

  def run(author = nil)
    activity.state = activity_state(author)
    activity.author = author
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

  def activity_state(author)
    author&.admin? ? :active : :pending
  end

end
