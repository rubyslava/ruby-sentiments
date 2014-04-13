def user_opens_eventer_application
  visit root_path
end

def application_shows_a_list_of_events
  expect(page).to have_content('All events')
  expect(page).to have_content('Rubyslava #38')
  expect(page).to have_content('Brnenske PyVo #38')
end

def user_signs_into_event(event)
  fail
end

def application_shows_user_is_attending(event)
  fail
end

def user_restarts_eventer_application
  visit root_path
end

def seed_eventer_application_with_events
  Event.create(name: 'Rubyslava #38', description: 'Architecture Edition', happening_on: Date.new(2014, 4, 24))
  Event.create(name: 'Brnenske PyVo #38', description: 'Compilers Edition', happening_on: Date.new(2014, 4, 24))
end
