class Activity < ApplicationRecord
  acts_as_taggable_on :tags
  ActsAsTaggableOn.force_lowercase = true
end
