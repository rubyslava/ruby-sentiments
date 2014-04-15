# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name "MyString"
    description "MyText"
    start_at "2014-04-15 12:18:04"
    end_at "2014-04-15 15:18:04"
  end
end
