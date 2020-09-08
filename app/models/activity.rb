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
  validates :days, presence: true, allow_nil: true

  enum state: [:pending, :active, :denied]

  scope :current, -> { where('end_date >= ? OR (end_date IS NULL AND start_date > ?)', Date.current, Date.current) }

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

end
