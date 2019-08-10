FactoryBot.define do
  sequence :email do |n|
    "example#{n}@example.com"
  end

  factory :user do
    first_name { 'Bob' }
    last_name { 'Builder' }
    email
    password { 'password' }
    password_confirmation { 'password' }

    trait :admin do
      role { 'admin' }
    end
  end

  factory :invalid_user, parent: :user do |user|
    user.first_name { nil }
  end
end
