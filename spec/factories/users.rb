# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name                  'qw'
    email                 'qw@qw.qw'
    password              'password'
    password_confirmation 'password'
  end
end
