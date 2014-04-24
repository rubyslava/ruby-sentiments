def user_signs_up_with(email, password)
  visit root_path
  click_link 'Sign up'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  fill_in 'Password confirmation', with: password
  click_button 'Sign up'
end

def user_choose_to_attend(event_name)
  find('tr', text: event_name).click_link 'Join'
end

def user_signs_in_with(email, password)
  visit root_path
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Sign in'
end

def user_logs_out
  click_link 'Logout'
end