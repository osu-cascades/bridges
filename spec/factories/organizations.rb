FactoryBot.define do
  factory :organization do
    name { 'Lettuce Taco Bout It' }
    location { 'Bend' }
    ages_served { '15 - 18' }
    programs { 'Summer camps' }
    contact_number { '123-456-7890' }
    contact_email { 'lettuce@tacos.com' }
    website { 'http://lettuce-taco-bout-it.com' }
  end

  factory :invalid_organization, parent: :organization do |organization|
    organization.name { nil }
  end
end
