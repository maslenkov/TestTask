# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invite do
    sequence(:invite)      {|n| "invite##{n}" }
    status true
  end
end
