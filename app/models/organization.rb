class Organization < ApplicationRecord
  has_one_attached :logo
  acts_as_taggable_on :tags
  ActsAsTaggableOn.force_lowercase = true
  ActsAsTaggableOn.remove_unused_tags = true

  validates_presence_of :name
end
