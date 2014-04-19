# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
sample_date_start = Date.today() - 10.days
Rails.application.secrets.sample_events_count.to_i.times.each do |i|
  Event.create do |event|
    event.name = "Sample Event ##{i}"
    event.description = Faker::Lorem.paragraph(50)
    event.date = sample_date_start + i.days
    event.from_time = Time.now + i.hours
    event.to_time = event.from_time + i.hours
  end
end
puts "CREATED #{Rails.application.secrets.sample_events_count} SAMPLE EVENTS"