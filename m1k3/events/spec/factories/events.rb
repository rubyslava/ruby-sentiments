# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name "MyString"
    description "MyText"
    start_at 2.days.from_now
    end_at 2.days.from_now.advance(hours: 2)
  end
end
