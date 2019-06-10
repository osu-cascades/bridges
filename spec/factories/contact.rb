FactoryBot.define do
  factory :contact do
    name { 'Hannah Montana' }
    email { 'hmontana@example.com' }
    phone_number { '123-456-7890' }
    message { "TOP SECRET: I'm actually Miley Cyrus with a wig on" }
  end
end
