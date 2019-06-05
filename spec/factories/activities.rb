FactoryBot.define do
  factory :activity do
    who { 'Everyone' }
    what { 'Tacos' }
    where { 'Bend' }
    add_attribute(:when) { 'Tomorrow' }
    how { 'Contact Howard at 123-456-7890' }
    details { "Come support 'Lettuce Taco Bout It' at this FUNdraiser" }
    title { 'Lettuce Taco Bout It FUNdraiser' }
  end

  factory :invalid_activity, parent: :activity do |activity|
    activity.title { nil }
  end
end
