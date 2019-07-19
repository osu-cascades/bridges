FactoryBot.define do
  factory :contact do
    to { 1 }
    to_name { 'TMZ' }
    name { 'Hannah Montana' }
    email { 'hmontana@example.com' }
    phone_number { '123-456-7890' }
    message { "TOP SECRET: I'm actually Miley Cyrus with a wig on" }
  end
end
