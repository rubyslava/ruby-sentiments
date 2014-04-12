Event.destroy_all

EVENTS = [
  { name: 'Rubyslava', date: Date.today, from_time: '18:00' },
  { name: 'Rubyslava', date: 1.month.from_now, from_time: '18:00' }
]

EVENTS.each do |event_data|
  Event.create(event_data)
end
