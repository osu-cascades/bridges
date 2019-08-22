FactoryBot.define do
  factory :activity do
    location { 'Bend' }
    when_start { '01/01/2020 10:00' }
    when_end { '01/11/2020 10:00' }
    contact_name { 'Howard' }
    contact_email { 'howard@example.com' }
    contact_number { '123-456-7890' }
    organization_name { 'Taco Tuesday' }
    description { "Come support 'Lettuce Taco Bout It' at this FUNdraiser" }
    title { 'Lettuce Taco Bout It FUNdraiser' }
  end

  factory :invalid_activity, parent: :activity do |activity|
    activity.title { nil }
  end
end
