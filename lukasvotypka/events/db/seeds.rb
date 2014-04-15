# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

(1..10).to_a.each do |idx|
  d = DateTime.now + (1..365).to_a.shuffle.first.days

  FactoryGirl.create('event', {
    title: "Event #{idx}", start_time: d})
end

(1..2).to_a.each do |idx|
  FactoryGirl.create('user', {
    email: "test-#{idx}@test.test",
    password: 'testtest',
    password_confirmation: 'testtest'
  })
end
