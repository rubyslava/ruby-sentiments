def user_opens_eventer_application
  visit root_path
end

def application_shows_a_list_of_events
  expect(page).to have_content('All events')
  expect(page).to have_content('Rubyslava #38')
  expect(page).to have_content('Brnenske PyVo #38')
end

def user_signs_into_event(event)
  find('tr', text: event).find('a', text: 'Attend').click
end

def application_shows_user_is_attending(event)
  expect(find('tr', text: event)).to have_content('Going')
end

def user_restarts_eventer_application
  click_link 'Sign out'

  # https://coderwall.com/p/16yg4q
  Capybara.reset_sessions!

  visit root_path
end

def seed_eventer_application_with_events
  Ar::Event.create(name: 'Rubyslava #38', description: 'Architecture Edition', date: Date.new(2014, 4, 24))
  Ar::Event.create(name: 'Brnenske PyVo #38', description: 'Compilers Edition', date: Date.new(2014, 4, 24))
end

def user_registers_a_new_account(email)
  click_link 'Sign up'
  fill_in 'Email', with: email
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  click_button 'Sign up'
end

def user_signs_in_as(email)
  click_link 'Sign in'
  fill_in 'Email', with: email
  fill_in 'Password', with: 'password'
  click_button 'Sign in'
end
