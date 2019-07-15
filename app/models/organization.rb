class Organization < ApplicationRecord
  acts_as_taggable_on :tags
  ActsAsTaggableOn.force_lowercase = true
  ActsAsTaggableOn.remove_unused_tags = true

  validates_presence_of :name
  enum state: [:pending, :active, :denied]
end
