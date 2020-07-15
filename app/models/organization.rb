class Organization < ApplicationRecord

  NAME_FOR_NONE = 'None'

  has_one_attached :logo
  acts_as_taggable_on :tags
  ActsAsTaggableOn.force_lowercase = true
  ActsAsTaggableOn.remove_unused_tags = true

  validates_presence_of :name

  has_many :users

  scope :active, -> { where(active: true) }

  def to_s
    name
  end

end
