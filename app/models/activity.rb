class Activity < ApplicationRecord

  acts_as_taggable_on :tags
  ActsAsTaggableOn.force_lowercase = true
  ActsAsTaggableOn.remove_unused_tags = true

  belongs_to :author, class_name: 'User', optional: true

  validates :title, presence: true
  validates :url, format: {
    with: URI.regexp(['http', 'https']),
    message: 'must start with http or https'
  }, if: -> { url.present? }
  validate :end_date_after_start_date

  enum state: [:pending, :active, :denied]

  scope :current, -> { where('when_end >= ? OR (when_end IS NULL AND when_start > ?)', Date.current, Date.current) }

  private

  def end_date_after_start_date
    return if when_end.blank? || when_start.blank?

    if when_end < when_start
      errors.add(:when_end, "must be after the start date")
    end
  end

end
