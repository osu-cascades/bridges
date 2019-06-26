FactoryBot.define do
  factory :activity do
    who { 'Everyone' }
    what { 'Tacos' }
    where { 'Bend' }
    when_start { '01/01/2020 10:00' }
    when_end { '01/11/2020 10:00' }
    how { 'Contact Howard at 123-456-7890' }
    details { "Come support 'Lettuce Taco Bout It' at this FUNdraiser" }
    title { 'Lettuce Taco Bout It FUNdraiser' }
  end

  factory :invalid_activity, parent: :activity do |activity|
    activity.title { nil }
  end
end
