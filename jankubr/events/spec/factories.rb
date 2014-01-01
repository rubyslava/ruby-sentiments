FactoryGirl.define do
  sequence :email do |n|
    Faker::Internet.email
  end

  sequence :name do |n|
    (Faker::Name.name + n.to_s).gsub("'", '')
  end

  sequence :description do |n|
    Faker::Lorem.paragraphs.to_s
  end

  sequence :phone do |n|
    "#{n+1}#{Faker::PhoneNumber.phone_number.gsub(/[^\d]/, '')}"[0..8].gsub(/(\d{3})/, "\\1_").split("_").join(" ")
  end

  sequence :serial do |n|
    "#{Faker::Lorem.words.first}#{n}"
  end

  sequence :last_name do |n|
    Faker::Name.last_name.gsub("'", '')
  end

  sequence :first_name do |n|
    Faker::Name.last_name.gsub("'", '')
  end

  factory :user do
    name
    email
    password "123456"
    password_confirmation "123456"
  end

  factory :event do
    user
    name
    date { Date.tomorrow }
    starts_at { Time.now + 3.hours }
    ends_at { Time.now + 4.hours }
    description
  end
end
