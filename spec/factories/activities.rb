FactoryBot.define do
  factory :activity do
    who { 'Everyone' }
    what { 'Tacos' }
    where { 'Bend' }
    when_start { Time.now }
    when_end { Time.now + 10.days }
    how { 'Contact Howard at 123-456-7890' }
    details { "Come support 'Lettuce Taco Bout It' at this FUNdraiser" }
    title { 'Lettuce Taco Bout It FUNdraiser' }
  end

  factory :invalid_activity, parent: :activity do |activity|
    activity.title { nil }
  end
end
