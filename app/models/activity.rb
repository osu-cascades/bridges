class Activity < ApplicationRecord
  acts_as_taggable_on :tags
  ActsAsTaggableOn.force_lowercase = true
  ActsAsTaggableOn.remove_unused_tags = true

  validates :title, presence: true

  enum state: [:pending, :active, :denied]
end