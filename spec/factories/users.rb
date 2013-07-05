# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name                  'example'
    sequence(:email)      {|n| "email#{n}@factory.com" }
    password              'password'
    password_confirmation 'password'
  end
end
