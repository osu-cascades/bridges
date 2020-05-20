FactoryBot.define do
  factory :contact do
    to { 1 }
    to_name { 'Fake To Name' }
    name { 'Fake' }
    email { 'fake@fake.com' }
    phone_number { '123-456-7890' }
    message { 'Fake message' }
  end
end
