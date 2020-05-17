FactoryBot.define do
  factory :organization do
    name { 'Fake Organization' }
    location { 'Fake Location' }
    ages_served { '15 - 18' }
    programs { 'Fake Programs' }
    contact_number { '123-456-7890' }
    contact_email { 'fake@fake.com' }
    website { 'http://fake.com' }
  end

  factory :invalid_organization, parent: :organization do |organization|
    organization.name { nil }
  end
end
