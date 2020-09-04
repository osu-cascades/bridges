FactoryBot.define do
  factory :activity do
    title { 'Lettuce Taco Bout It FUNdraiser' }
    start_date { '01/01/2020' }
    end_date { '01/11/2020' }
    start_time { '10:00' }
    end_time { '12:00' }
    location { 'Bend' }
    contact_name { 'Howard' }
    contact_email { 'howard@example.com' }
    contact_number { '123-456-7890' }
    organization_name { 'Taco Tuesday' }
    description { "Come support 'Lettuce Taco Bout It' at this FUNdraiser" }
  end

  factory :invalid_activity, parent: :activity do |activity|
    activity.title { nil }
  end
end
