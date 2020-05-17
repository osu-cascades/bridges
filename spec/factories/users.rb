FactoryBot.define do

  factory :user do
    first_name { 'Fake' }
    last_name { 'User' }
    sequence(:email) { |n| "fake_#{n}@fake.com" }
    password { 'password' }
    password_confirmation { 'password' }

    trait :admin do
      last_name { 'Admin' }
      role { 'admin' }
    end
  end

  factory :invalid_user, parent: :user do |user|
    user.first_name { nil }
  end
end
