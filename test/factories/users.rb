FactoryBot.define do
  factory :user do
    first_name { 'Bob' }
    last_name { 'Builder' }
    email { 'example@example.com' }
    password { 'password' }

    trait :admin do
      role { 'admin' }
    end
  end
end
