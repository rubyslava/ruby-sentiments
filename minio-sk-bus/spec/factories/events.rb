# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    sequence(:name) {|n| "Rubyslava##{n}" }
    description "Some description"
    scheduled_on "2014-04-23"
    beginning_at "2014-04-23 23:18:16"
    ending_at "2014-04-23 23:18:16"
  end
end
